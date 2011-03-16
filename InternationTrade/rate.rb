class Rate
  include HappyMapper

  element :from, String
  element :to, String
  element :conversion, Float
  
  def initialize( from, to, conversion )
    @from = from
    @to = to
    @conversion = conversion
  end
  
  class << self
    alias_method :orig_parse, :parse
  end
  def self.parse( file_path )
    orig_parse( File.read( file_path ) )
  end
  
  
  def self.combinations( rates )
    combinations = rates.dup
    
    combinations += invert_combinations( combinations )
    combinations += branch_combinations( combinations )
    
    return combinations.uniq
  end
  
  def self.invert_combinations( rates )
    invert_rates = []
    
    rates.each do |rate|
      invert_rates << Rate.new( rate.to, rate.from, (1/rate.conversion) )
    end
    
    return invert_rates
  end
  
  def self.branch_combinations( rates )
    branch_rates = []
    
    rates.each do |rate_a|
      rates.each do |rate_b|
        next  if rate_a == rate_b
        branch_rates << Rate.new( rate_a.to, rate_b.from, (rate_a.conversion*rate_b.conversion) )
      end
    end
    
    return branch_rates
  end
  
  def ==( other )
    result = (from == other.from && to == other.to)    
    puts "(#{result}) this: #{self.inspect} -> other: #{other.inspect}"
    
    return result
  end
end