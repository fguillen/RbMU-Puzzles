require_relative 'test_helper'


class InternationalTradeTest < Test::Unit::TestCase
  def setup
    InternationalTrade.stubs( :db_path ).returns( FIXTURES_PATH )
  end
  
  def test_total_sales
    assert_equal( 134.22, InternationalTrade.total_sales( 'DM1182', 'USD' ) )
  end
  
  def test_total_sales_1
    db_trans = [
      Tran.new( 'Store', 'i1', 1, 'AUD' )
    ]
    
    rates_index = [
      Rate.new( 'AUD', 'USD', 1.0169711 ),
    ]
    
    InternationalTrade.stubs( :db_trans ).returns( db_trans )
    Rate.stubs( :index ).returns( rates_index )
    
    assert_equal( 1.02, InternationalTrade.total_sales( 'i1', 'USD' ) )
  end

  def test_total_sales_2
    db_trans = [
      Tran.new( 'Store', 'i1', 1, 'AUD' ),
      Tran.new( 'Store', 'i1', 2, 'USD' )
    ]
    
    rates_index = [
      Rate.new( 'AUD', 'USD', 1.0169711 ),
      Rate.new( 'USD', 'USD', 1 )
    ]
    
    InternationalTrade.stubs( :db_trans ).returns( db_trans )
    Rate.stubs( :index ).returns( rates_index )
    
    assert_equal( 3.02, InternationalTrade.total_sales( 'i1', 'USD' ) )
  end
  
  def test_total_sales_3
    db_trans = [
      Tran.new( 'Store', 'i1', 1, 'AUD' ),
      Tran.new( 'Store', 'i2', 2, 'USD' )
    ]
    
    rates_index = [
      Rate.new( 'AUD', 'USD', 1.0169711 )
    ]
    
    InternationalTrade.stubs( :db_trans ).returns( db_trans )
    Rate.stubs( :index ).returns( rates_index )
    
    assert_equal( 1.02, InternationalTrade.total_sales( 'i1', 'USD' ) )
  end
  
  def test_total_sales_4
    db_trans = [
      Tran.new( 'Store', 'DM1210', 70.00, 'USD' ),
      Tran.new( 'Store', 'DM1182', 19.68, 'AUD' ),
      Tran.new( 'Store', 'DM1182', 58.58, 'AUD' ),
      Tran.new( 'Store', 'DM1210', 68.76, 'USD' ),
      Tran.new( 'Store', 'DM1182', 54.64, 'USD' )
    ]
    
    rates_index = [
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
    
    InternationalTrade.stubs( :db_trans ).returns( db_trans )
    Rate.stubs( :index ).returns( rates_index )
    
    assert_equal( 134.22, InternationalTrade.total_sales( 'DM1182', 'USD' ) )
  end
end
