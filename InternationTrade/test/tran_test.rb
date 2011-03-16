require_relative 'test_helper'

class TranTest < Test::Unit::TestCase
  def test_parse
    trans = Tran.parse( "#{FIXTURES_PATH}/TRANS.csv" )
    
    assert_equal( 5, trans.size )
    assert_equal( 'Yonkers', trans.first.store )
    assert_equal( 'DM1210', trans.first.sku )
    assert_equal( 70.00, trans.first.amount )
    assert_equal( 'USD', trans.first.currency )
  end
end