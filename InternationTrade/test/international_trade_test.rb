require_relative 'test_helper'


class InternationalTradeTest < Test::Unit::TestCase
  def setup
    InternationalTrade.stubs( :db_path ).returns( FIXTURES_PATH )
  end
  
  def test_total_sales
    assert_equal( 134.22, InternationalTrade.total_sales( 'DM1182', 'USD' ) )
  end
  
  def test_convert
    assert_equal( 1.0079, InternationalTrade.convert( 'AUD', 'CAD', 1 ) )
  end
  
  def test_conversion
    assert_equal( 1, InternationalTrade.conversion( 'USD', 'USD' ) )
    assert_equal( 1.0079, InternationalTrade.conversion( 'AUD', 'CAD' ) )
    assert_equal( 1.0079 * 1.0090, InternationalTrade.conversion( 'AUD', 'USD' ) )
    assert_equal( 1.0079, InternationalTrade.convert( 'CAD', 'AUD', 1 ) )
  end
end