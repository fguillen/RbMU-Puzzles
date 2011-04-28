require 'happymapper'
require 'bigdecimal'
require_relative 'rate'
require_relative 'tran'

module InternationalTrade
  DB_PATH = File.expand_path( "#{File.dirname(__FILE__)}/../db" )
  
  def self.total_sales( sku, currency )
    init_rates_index
    trans = db_trans.select { |e| e.sku == sku }
    total_amount = trans.inject(0) do |sum,e| 
      ( sum + Rate.convert( e.currency, currency, e.amount ) ).round(2) 
    end
        
    return total_amount
  end

  def self.init_rates_index
    Rate.create_index( "#{db_path}/RATES.xml" )
  end
  
  def self.db_trans
    @db_trans ||= Tran.parse( "#{db_path}/TRANS.csv" )
  end
  
  def self.db_path
    DB_PATH
  end
end