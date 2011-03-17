class Rate
  include HappyMapper

  element :from, String
  element :to, String
  element :conversion, Float
  
  def initialize( from = nil, to = nil, conversion = nil )
    @from = from
    @to = to
    @conversion = conversion
  end
  
  def self.convert( from, to, amount )
    rate = index.select { |e| e.from == from && e.to == to }.first
    
    if rate.nil?
      raise Exception, "no Rate for '#{from}' -> '#{to}'"
    end
    
    amount_converted = round( amount * rate.conversion )
    
    return amount_converted
  end
  
  def self.index
    @index
  end
  
  # parse the seed file and create an index 
  # of all possible combinations
  def self.create_index( seed_file_path )
    rates_seed = parse( File.read( seed_file_path ) )
    @index = combinations_all( rates_seed )
  end
  
  def self.combinations_all( rates )
    combinations = rates.dup
    
    combinations += combinations_inverted( combinations )
    combinations += combinations_equalized( combinations )
    combinations += combinations_chained( combinations )
    
    return combinations.uniq { |e| "#{e.from}|#{e.to}" }
  end
  
  # from == to
  def self.combinations_equalized( rates )
    equal_rates = []
    
    rates.each do |rate|
      equal_rates << Rate.new( rate.from, rate.from, 1.00 )
      equal_rates << Rate.new( rate.to, rate.to, 1.00 )
    end
    
    return equal_rates.uniq { |e| "#{e.from}|#{e.to}" }
  end
  
  # from -> to
  def self.combinations_inverted( rates )
    invert_rates = []
    
    rates.each do |rate|
      invert_rates << Rate.new( rate.to, rate.from, (1/rate.conversion) )
    end
    
    return invert_rates.uniq { |e| "#{e.from}|#{e.to}" }
  end
  
  # from,to -> from,to -> from,to
  def self.combinations_chained( rates )
    chained_rates = []
    
    rates.each do |rate_a|
      rates.select { |e| rate_a.to == e.from }.each do |rate_b|
        new_rate = Rate.new( rate_a.from, rate_b.to, (rate_a.conversion*rate_b.conversion) )
        next  if( rates.select { |e| new_rate.from == new_rate.to }.size != 0 ) # next if equalized
        next  if( rates.select { |e| e.from == new_rate.from && e.to == new_rate.to }.size != 0 ) # next if already exists in rates
        next  if( chained_rates.select { |e| e.from == new_rate.from && e.to == new_rate.to }.size != 0 ) # next if already exists in chained rates
        chained_rates << new_rate
      end
    end

    if( chained_rates.empty? )
      return chained_rates # we have already finish to find new chained combinations
    else
      return chained_rates + combinations_chained( rates + chained_rates )
    end
  end
  
  def self.round( float )
    BigDecimal.new( float.to_s ).round( 2, BigDecimal::ROUND_HALF_EVEN ).to_f
  end
  
  def to_s
    "#{from}|#{to}|#{conversion}"
  end
end