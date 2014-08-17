require 'bigdecimal'

# Public: Tax rate calculator for different types of Item object
#
# It is responsible for calculating proper tax rate
# will be used by Purchase object to further calcualte tax price
class TaxRater
    # Get/Set for basic and imported tax rate
    attr_accessor :base, :impRate
    
    # Public: Initialize a TaxRater object
    #
    # base    - The BigDecimal basic tax rate (default: 0.10)
    # impRate - The BigDecimal imported tax rate (default: 0.05)
    def initialize (base=0.10, impRate=0.05)
        @base = BigDecimal(base.to_s)
        @impRate = BigDecimal(impRate.to_s)
    end

    # Public: Calculate tax rate for an Item object
    #
    # item - Item object
    #
    # Returns the BigDecimal tax rate applied on this item
    def calculate (item)
        rate = item.exempt ? BigDecimal(0.to_s) : @base
        rate += @impRate if item.imported
        return rate
    end
end
