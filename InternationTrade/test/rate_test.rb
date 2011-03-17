require_relative 'test_helper'

class RateTest < Test::Unit::TestCase
  def test_parse
    rates = Rate.parse( File.read( "#{FIXTURES_PATH}/RATES.xml" ) )
    
    assert_equal( 3, rates.size )
    assert_equal( 'AUD', rates.first.from )
    assert_equal( 'CAD', rates.first.to )
    assert_equal( 1.0079, rates.first.conversion )
  end
  
  def test_create_index
    Rate.expects( :combinations_all ).returns( 'wadus' )
    
    assert_equal( 'wadus', Rate.create_index( "#{FIXTURES_PATH}/RATES.xml" ) )
  end
  
  def test_convert
    rate = Rate.new( 'AUD', 'CAD', 1.0079 )
    
    Rate.stubs( :index ).returns( [rate] )
    
    assert_equal( 1.01, Rate.convert( 'AUD', 'CAD', 1 ) )
    assert_equal( 2.02, Rate.convert( 'AUD', 'CAD', 2 ) )
  end
  
  def test_combinations_all
    combinations = [
      Rate.new( 'AUD', 'CAD', 1.0079 ),
      Rate.new( 'CAD', 'USD', 1.009 ),
      Rate.new( 'USD', 'CAD', 0.9911 ),
      Rate.new( 'CAD', 'AUD', 0.9921619208254787 ),
      Rate.new( 'AUD', 'AUD', 1.0 ),
      Rate.new( 'CAD', 'CAD', 1.0 ),
      Rate.new( 'USD', 'USD', 1.0 ),
      Rate.new( 'AUD', 'USD', 1.0169711 ),
      Rate.new( 'USD', 'AUD', 0.9833316797301319 )
    ]
    
    rate1 = Rate.new( 'AUD', 'CAD', 1.0079 )
    rate2 = Rate.new( 'CAD', 'USD', 1.0090 )
    rate3 = Rate.new( 'USD', 'CAD', 0.9911 )
    rates = [rate1, rate2, rate3]
    
    result = Rate.combinations_all( rates )
    
    assert_equal( combinations.map { |e| e.to_s }, result.map { |e| e.to_s } )
  end
  
  def test_combinations_equalized
    combinations = [
      Rate.new( 'AUD', 'AUD', 1.0 ),
      Rate.new( 'CAD', 'CAD', 1.0 ),
      Rate.new( 'USD', 'USD', 1.0 )
    ]
      
    rate1 = Rate.new( 'AUD', 'CAD', 1.0079 )
    rate2 = Rate.new( 'CAD', 'USD', 1.0090 )
    rate3 = Rate.new( 'USD', 'CAD', 0.9911 )
    rates = [rate1, rate2, rate3]
    
    result = Rate.combinations_equalized(rates)
    
    assert_equal( combinations.map { |e| e.to_s }, result.map { |e| e.to_s } )
  end
  
  def test_combinations_chained
    combinations = [
      Rate.new( 'AUD', 'USD', 1.0169711 )
    ]
      
    rate1 = Rate.new( 'AUD', 'CAD', 1.0079 )
    rate2 = Rate.new( 'CAD', 'USD', 1.0090 )
    rate3 = Rate.new( 'USD', 'CAD', 0.9911 )
    rates = [rate1, rate2, rate3]
    
    result = Rate.combinations_chained(rates)
        
    assert_equal( combinations.map { |e| e.to_s }, result.map { |e| e.to_s } )
  end
  
  def test_combinations_chained_two_jumps
    combinations = [
      Rate.new( 'AUD', 'USD', 8 ),
      Rate.new( 'CAD', 'EUR', 24 ),
      Rate.new( 'AUD', 'EUR', 48 )
    ]
      
    rate1 = Rate.new( 'AUD', 'CAD', 2 )
    rate2 = Rate.new( 'CAD', 'USD', 4 )
    rate3 = Rate.new( 'USD', 'EUR', 6 )
    rates = [rate1, rate2, rate3]
    
    result = Rate.combinations_chained(rates)
        
    assert_equal( combinations.map { |e| e.to_s }, result.map { |e| e.to_s } )
  end
  
  def test_round
    assert_equal( 134.22, Rate.round( 134.225 ) )
  end
end

# result.each do |result|
#   puts "Rate.new( '#{result.from}', '#{result.to}', #{result.conversion} ),"
# end