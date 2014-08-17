require "spec_helper"

describe Item do
    # Initialize different type of Item object to test
    before :each do
        @item_normal = Item.new "cosmetics", "perfume", 27.99
        @item_normal_imported = Item.new "cosmetics", "imported perfume", 30.99
        @item_book = Item.new "book", "Ruby Monk", 20.50
        @item_food = Item.new "food", "choclate", 10.00
        @item_medicine = Item.new "medicine", "headache pills", 9.75
        @item_food_imported = Item.new "food", "imported choclate", 11.25
    end

    # Examples to test if Item constructor returns proper object
    describe "#new" do
        it 'return an Item object' do
            @item_normal.should be_an_instance_of Item
            @item_normal_imported.should be_an_instance_of Item
            @item_book.should be_an_instance_of Item
            @item_medicine.should be_an_instance_of Item
        end
    end

    # Examples to test Item object's @type 
    describe '#type' do
        it 'Ruby Monk is a type of book' do
            @item_book.type.should eql 'book'
        end
        it 'imported perfume is a type of cosmetics' do
            @item_normal_imported.type.should eql 'cosmetics'
        end
        it 'headache pills is a type of medicine' do
            @item_medicine.type.should eql 'medicine'
        end
        it 'imported chocolate is a type of food' do
            @item_food_imported.type.should eql 'food'
        end
    end

    # Examples to test Item object's @exempt 
    describe '#exempt' do
        it 'Ruby Monk is basic tax free' do
            @item_book.exempt.should eql true
        end
        it 'imported perfume is not basic tax free' do
            @item_normal_imported.exempt.should eql false
        end
        it 'headache pills is basic tax free' do
            @item_medicine.exempt.should eql true
        end
        it 'imported chocolate is basic tax free' do
            @item_food_imported.exempt.should eql true
        end
    end

    # Examples to test Item object's @imported
    describe '#imported' do
        it 'Ruby Monk is not imported' do
            @item_book.imported.should eql false
        end
        it 'imported perfume is imported' do
            @item_normal_imported.imported.should eql true
        end
        it 'headache pills is not imported' do
            @item_medicine.imported.should eql false
        end
        it 'imported choclate is imported' do
            @item_food_imported.imported.should eql true
        end
    end
end
