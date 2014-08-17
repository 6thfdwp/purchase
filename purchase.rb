require 'bigdecimal'

# Public: Class represents an Array of Item objects in a purchase
#
# It is mainly responsible for two things:
# Calculate the tax and tax applied price for each item
# Sum the tax and price for all items and print the receipt
class Purchase
    # Pulibc: Get/Set for an Array of purchased records
    # each of which is an Array with two elements: [<quantity>, <Item object>]
    attr_accessor :records

    # Public: Initialize a purchase
    #
    # inputs - An Array of comma delimited String each of which
    #          represents a purchased record with the format 
    #          "<quantity>, <type>, <name>, <price>"
    #          The last three is used to create an Item object
    def initialize (inputs = [])
        @records = []
        inputs.each do |input|
            quantity, type, name, price = input.split(",").map { |e| e.strip }
            @records.push [quantity.to_i, Item.new(type, name, price)]
        end
        @rater = TaxRater.new
    end

    # Public: Round tax to the nearest 0.05
    #
    # t - the orginal BigDecimal tax
    #
    # Returns rounded BigDecimal tax
    def round_tax (t)
        r = BigDecimal( 0.05.to_s )
        (t / r).round * r
    end

    # Public: Calculate the tax and the tax applied price for each item
    # based on the constructed @records attribute
    #
    # Returns an Array of Hash object each of which has 
    # the format {:quantity"=>1,:name=>chocolate,:tax=>0.99,:tprice=>11.99}
    def calculate
        result = []
        @records.each do |record|
            quantity, item = record
            rate = @rater.calculate item
            price = item.price * quantity
            t = self.round_tax(price * rate)
            result.push( {
                :quantity =>quantity, :name =>item.name, 
                :tax =>t, :tprice =>t + price
            } )
        end
        return result
    end

    # Public: Print the receipt to standard output
    #
    # result - An array of calculated result for each item 
    #          containing tax and tax applied price
    #
    # Returns total taxes and price for all items
    def print_receipt (result)
        taxes, total = 0, 0
        puts "-" * 50
        result.each do |each|
            quantity, name, tax, tprice = each[:quantity], each[:name], each[:tax] , each[:tprice]
            puts "#{quantity}, #{name}, #{'%.2f' % tprice.to_f}"
            taxes += tax
            total += tprice
        end
        puts "\nSales Taxes: #{'%.2f' % taxes.to_f}"
        puts "Total: #{'%.2f' % total.to_f}"
        puts "-" * 50
        return taxes, total
    end
end
