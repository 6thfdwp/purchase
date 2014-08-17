require 'spec_helper'

describe Purchase do
    # Initialize different Purchase object based on input
    before :all do
        input1 = [
            "1, book, book, 12.49",
            "1, music, music cd, 14.99",
            "1, food, chocolate bar, 0.85"
        ]
        input2 = [
            "1, food, imported box of chocolates, 10.00",
            "1, cosmetics, imported bottle of perfume, 47.50"
        ]
        input3 = [
            "1, cosmetics, imported bottle of perfume, 27.99",
            "1, cosmetics, bottle of perfume, 18.99",
            "1, medicine, packet of headache pills, 9.75",
            "1, food, box of imported chocolates, 11.25"
        ]
        input4 = [
            "2, food, imported box of chocolates, 10.00",
            "3, cosmetics, imported bottle of perfume, 47.50"
        ]
        #File.open 'input1.yml', 'w' do |f|
            #f.write YAML::dump input1
        #end
        #File.open 'input2.yml', 'w' do |f|
            #f.write YAML::dump input2
        #end
        #File.open 'input3.yml', 'w' do |f|
            #f.write YAML::dump input3
        #end

        @purchase1 = Purchase.new input1
        @purchase2 = Purchase.new input2
        @purchase3 = Purchase.new input3
        @purchase4 = Purchase.new input4
    end

    # Examples to test if Purchase @records contains proper Item objects
    describe '#records' do
        it 'Purchase records for input1' do
            records = @purchase1.records
            records.length.should eq 3
            records.each do |rec|
                quantity, item = rec
                item.should be_an_instance_of Item
            end
        end
        it 'Purchase records for input2' do
            records = @purchase2.records
            records.length.should eq 2
            records.each do |rec|
                quantity, item = rec
                item.should be_an_instance_of Item
            end
        end
        it 'Purchase records for input3' do
            records = @purchase3.records
            records.length.should eq 4
            records.each do |rec|
                quantity, item = rec
                item.should be_an_instance_of Item
            end
        end
    end

    # Example to test rounding the tax to the nearest 0.05
    describe "#round_tax" do
        it "to nearest 0.05" do
            @purchase1.round_tax(1.499).should eq 1.50
            @purchase1.round_tax(7.625).should eq 7.65
            @purchase1.round_tax(0.5625).should eq 0.55
        end
    end

    # Examples to test if the tax and price for each Item
    # in the @records are expected
    describe '#calculate' do
        it 'tax applied price for each item in input1' do
            result = @purchase1.calculate
            result[0][:tprice].should eq 12.49
            result[1][:tprice].should eq 16.49
            result[2][:tprice].should eq 0.85
        end
        it 'tax applied price for each item in input2' do
            result = @purchase2.calculate
            result[0][:tprice].should eq 10.50
            result[1][:tprice].should eq 54.65
        end
        it 'tax applied price for each item in input3' do
            result = @purchase3.calculate
            result[0][:tprice].should eq 32.19
            result[1][:tprice].should eq 20.89
            result[2][:tprice].should eq 9.75
            result[3][:tprice].should eq 11.85
        end
        it 'tax applied price for each item in input4' do
            result = @purchase4.calculate
            result[0][:tprice].should eq 21.00
            result[1][:tprice].should eq 163.9
        end
    end

    # Examples to test if the summed taxes and price for all items are expected
    describe '#print_receipt' do
        it 'total taxes and price for input1' do
            result = [
                {:quantity=>1, :name=>"book", :tax=>0, :tprice=>12.49},
                {:quantity=>1, :name=>"music cd", :tax=>1.5, :tprice=>16.49},
                {:quantity=>1, :name=>"chocolate bar", :tax=>0, :tprice=>0.85}
            ]
            taxes, total = @purchase1.print_receipt result
            taxes.should eql 1.50
            total.should eql 29.83
        end
        it 'total taxes and price for input2' do
            result = [
                {:quantity=>1, :name=>"imported box of chocolates", :tax=>0.5, :tprice=>10.50},
                {:quantity=>1, :name=>"imported bottle of perfume", :tax=>7.15, :tprice=>54.65}
            ]
            taxes, total = @purchase2.print_receipt result
            taxes.should eql 7.65
            total.should eql 65.15
        end
        it 'total taxes and price for input3' do
            result = [
                {:quantity=>1, :name=>"imported bottle of perfume", :tax=>4.2, :tprice=>32.19},
                {:quantity=>1, :name=>"bottle of perfume", :tax=>1.90, :tprice=>20.89},
                {:quantity=>1, :name=>"packet of headache pills", :tax=>0.0, :tprice=>9.75},
                {:quantity=>1, :name=>"imported box of chocolates", :tax=>0.55, :tprice=>11.80}
            ]
            taxes, total = @purchase3.print_receipt result
            taxes.should eql 6.70
            total.should eql 74.68
        end
    end
end
