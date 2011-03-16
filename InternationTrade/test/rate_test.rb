require_relative 'test_helper'

class RateTest < Test::Unit::TestCase
  def test_parse
    rates = Rate.parse( "#{FIXTURES_PATH}/RATES.xml" )
    
    assert_equal( 3, rates.size )
    assert_equal( 'AUD', rates.first.from )
    assert_equal( 'CAD', rates.first.to )
    assert_equal( 1.0079, rates.first.conversion )
  end
  
  def test_combinations
    combinations = 
      [
        
        Rate.new( 'AUD', 'CAD', 1.0079 ),
        Rate.new( 'CAD', 'USD', 1.009 ),
        Rate.new( 'USD', 'CAD', 0.9911 ),
        Rate.new( 'CAD', 'AUD', 0.9921619208254787 ),
        Rate.new( 'USD', 'CAD', 0.9910802775024778 ),
        Rate.new( 'CAD', 'USD', 1.0089799212995663 ),
        Rate.new( 'CAD', 'CAD', 1.0169711 ),
        Rate.new( 'CAD', 'USD', 0.99892969 ),
        Rate.new( 'CAD', 'CAD', 1.0 ),
        Rate.new( 'CAD', 'USD', 0.9989098116947475 ),
        Rate.new( 'CAD', 'CAD', 1.0169508626778327 ),
        Rate.new( 'USD', 'AUD', 1.0169711 ),
        Rate.new( 'USD', 'USD', 1.0000198999999999 ),
        Rate.new( 'USD', 'CAD', 1.0010913781129078 ),
        Rate.new( 'USD', 'USD', 1.0 ),
        Rate.new( 'CAD', 'AUD', 0.99892969 ),
        Rate.new( 'CAD', 'CAD', 1.0000198999999999 ),
        Rate.new( 'CAD', 'CAD', 0.9833316797301319 ),
        Rate.new( 'CAD', 'CAD', 1.0 ),
        Rate.new( 'AUD', 'AUD', 1.0 ),
        Rate.new( 'AUD', 'CAD', 1.0010913781129078 ),
        Rate.new( 'AUD', 'USD', 0.9833316797301319 ),
        Rate.new( 'AUD', 'USD', 0.9833121118191069 ),
        Rate.new( 'AUD', 'CAD', 1.001071456790918 ),
        Rate.new( 'CAD', 'AUD', 0.9989098116947475 ),
        Rate.new( 'CAD', 'CAD', 1.0 ),
        Rate.new( 'CAD', 'CAD', 0.9833121118191069 ),
        Rate.new( 'CAD', 'CAD', 0.9999801003960024 ),
        Rate.new( 'USD', 'AUD', 1.0169508626778327 ),
        Rate.new( 'USD', 'USD', 1.0 ),
        Rate.new( 'USD', 'CAD', 1.001071456790918 ),
        Rate.new( 'USD', 'USD', 0.9999801003960024 ),


      ]
    
    rate1 = Rate.new( 'AUD', 'CAD', 1.0079 )
    rate2 = Rate.new( 'CAD', 'USD', 1.0090 )
    rate3 = Rate.new( 'USD', 'CAD', 0.9911 )
    

    rates = [rate1, rate2, rate3]
    
    result = Rate.combinations(rates)
    
    result.each do |result|
      puts "Rate.new( '#{result.from}', '#{result.to}', #{result.conversion} ),"
    end
    
    puts result.inspect
    
    assert_equal( combinations, result )
  end
end