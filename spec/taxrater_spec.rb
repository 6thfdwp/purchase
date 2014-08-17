require 'spec_helper'

describe TaxRater do
    before :each do
        @item_normal = Item.new 'cosmetics', 'perfume', 27.99
        @item_normal_imported = Item.new 'cosmetics', 'imported perfume', 30.99
        @item_book = Item.new 'book', 'Ruby Monk', 20.50
        @item_food = Item.new 'food', 'choclate', 10.00
        @item_medicine = Item.new 'medicine', 'headache pills', 9.75
        @item_food_imported = Item.new 'food', 'imported choclate', 11.25

        @rater = TaxRater.new
    end

    # Examples to test TaxRater constructor with default
    # and specified parameters
    describe "#new" do
        context 'with no parameters' do
            it 'use default base (0.10) and import rate (0.05)' do
                @rater.base.should eql 0.10
                @rater.impRate.should eql 0.05
            end
        end
        context 'with two parameters' do
            it 'use specified parameters' do
                rater = TaxRater.new 0.15, 0.03
                rater.base.should eql 0.15
                rater.impRate.should eql 0.03
            end
        end
    end

    # Examples to test if TaxRater returns proper rate for
    # different Item objects
    describe '#calculate' do
        it 'perfume (normal products) have a rate of 0.10' do
            @rater.calculate(@item_normal).should eql 0.10
        end
        it 'perfume (imported normal products) have a rate of 0.10+0.05' do
            @rater.calculate(@item_normal_imported).should eql 0.15
        end
        it 'pills (medicine) have a rate of 0.0' do
            @rater.calculate(@item_medicine).should eql 0.0
        end
        it 'imported choclate (food) have a rate of 0.05' do
            @rater.calculate(@item_food_imported).should eql 0.05
        end
    end
end
