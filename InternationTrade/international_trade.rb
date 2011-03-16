require 'happymapper'
require_relative 'rate'
require_relative 'tran'

class InternationalTrade
  DB_PATH = File.expand_path( "#{File.dirname(__FILE__)}/db" )
  
  def self.total_sales( sku, currency )
    trans = db_trans.select { |e| e.sku == sku }
    total_amount = trans.inject(0) { |sum,e| sum + convert( e.currency, currency, e.amount ) }
    
    
    puts "total_amount: #{total_amount}"
  end
  
  def self.convert( from, to, amount )
    puts "XXX: from: #{from}"
    puts "XXX: to: #{to}"
    puts "XXX: amount: #{amount}"
    
    return amount * conversion( from, to )
  end
  
  def self.conversion( from, to, accumulator = [] )
    return 1  if from == to
    
    puts "---------"
    accumulator.each do |rate|
      puts "#{rate.from} -> #{rate.to}"
    end
    
    rate = db_rates.select { |e| e.from == from && e.to == to }.first
    
    
    
    if !rate.nil?
      accumulator << rate
      
      accumulator.each do |rate|
        puts "#{rate.from} -> #{rate.to}"
      end
      
      result = accumulator.inject(1) { |a,e| a * e.conversion }
      return result
    end
    
    rate = db_rates.select { |e| e.from == from }.first
    
    raise Exception, "not rate find from '#{from}'"  if rate.nil?
    
    accumulator << rate
    return conversion( rate.to, to, accumulator )
  end
  
  def self.db_rates
    @db_rates ||= Rate.parse( "#{db_path}/RATES.xml" )
  end
  
  def self.db_trans
    @db_trans ||= Tran.parse( "#{db_path}/TRANS.csv" )
  end
  
  def self.db_path
    DB_PATH
  end
end