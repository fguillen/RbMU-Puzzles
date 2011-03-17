require 'csv'

class Tran
  attr_accessor :store, :sku, :amount, :currency
  
  def initialize( store, sku, amount, currency )
    @store = store
    @sku = sku
    @amount = amount
    @currency = currency
  end
  
  def self.parse( file_path )
    result = []
    
    CSV.parse( File.read( file_path ) ) do |row|
      next  if row[0] == 'store'
      result << Tran.new( row[0], row[1], row[2].split(' ')[0].to_f, row[2].split(' ')[1] )
    end
    
    return result
  end
end