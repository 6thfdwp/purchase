require 'set'
require 'bigdecimal'

# Public: Class represents an item (product)
#
# It takes type, name and price to create an Item object
# Also initialize two boolean attributes
# @imported based on whether its name has word 'imported'
# @exempt based on whether its type is in the EXEMPTION set
class Item
    # Pulibc: Get/Set for attributes of Item
    attr_accessor :type, :name, :price, :imported, :exempt

    # Public: The Set of String item type that are tax exempted
    @@EXEMPTION = Set.new ['food', 'book', 'medicine']

    # Public: Initialize an item
    #
    # type  - The String type of an item
    # name  - The String name of an item
    # price - The String or Float price of an item
    def initialize (type, name, price)
        @type = type
        @name = name
        @price = BigDecimal(price.to_s)
        @imported = if name.include? "imported"
                        true 
                    else 
                        false
                    end
        @exempt = if @@EXEMPTION.include? type
                      true 
                  else 
                      false
                  end
    end

    # Public: String representation of an Item object
    #
    # Returns String representation
    def to_s
        return "#{@type}: #{@name}, #{@price}, imported #{@imported}, exempt #{@exempt}"
    end
end


