purchase
========

RSpec experimentation using simple purchase receipt example

Use command `rspec spec --format documentation`, the test result looks like below

```sh
Item
  #new
    return an Item object
  #type
    Ruby Monk is a type of book
    imported perfume is a type of cosmetics
    headache pills is a type of medicine
    imported chocolate is a type of food
  #exempt
    Ruby Monk is basic tax free
    imported perfume is not basic tax free
    headache pills is basic tax free
    imported chocolate is basic tax free
  #imported
    Ruby Monk is not imported
    imported perfume is imported
    headache pills is not imported
    imported choclate is imported
    
TaxRater
  #new
    with no parameters
      use default base (0.10) and import rate (0.05)
    with two parameters
      use specified parameters
  #calculate
    perfume (normal products) have a rate of 0.10
    perfume (imported normal products) have a rate of 0.10+0.05
    pills (medicine) have a rate of 0.0
    imported choclate (food) have a rate of 0.05
    
Purchase
  #records
    Purchase records for input1
    Purchase records for input2
    Purchase records for input3
  #round_tax
    to nearest 0.05
  #calculate
    tax applied price for each item in input1
    tax applied price for each item in input2
    tax applied price for each item in input3 (FAILED - 1)
    tax applied price for each item in input4
  #print_receipt
--------------------------------------------------
1, book, 12.49
1, music cd, 16.49
1, chocolate bar, 0.85

Sales Taxes: 1.50
Total: 29.83
--------------------------------------------------
    total taxes and price for input1
--------------------------------------------------
1, imported box of chocolates, 10.50
1, imported bottle of perfume, 54.65

Sales Taxes: 7.65
Total: 65.15
--------------------------------------------------
    total taxes and price for input2
--------------------------------------------------
1, imported bottle of perfume, 32.19
1, bottle of perfume, 20.89
1, packet of headache pills, 9.75
1, imported box of chocolates, 11.80

Sales Taxes: 6.65
Total: 74.63
--------------------------------------------------
    total taxes and price for input3 (FAILED - 2)
    
Failures:

  1) Purchase#calculate tax applied price for each item in input3
     Failure/Error: result[3][:tprice].should eq 11.85
       
       expected: 11.85
            got: 11.8 (#<BigDecimal:106fb6178,'0.118E2',8(20)>)
       
       (compared using ==)
     # ./spec/purchase_spec.rb:97

  2) Purchase#print_receipt total taxes and price for input3
     Failure/Error: taxes.should eql 6.70
       
       expected: 6.7
            got: 6.65
       
       (compared using eql?)
     # ./spec/purchase_spec.rb:135

Finished in 0.0129 seconds (files took 0.16248 seconds to load)
30 examples, 2 failures

Failed examples:

rspec ./spec/purchase_spec.rb:92 # Purchase#calculate tax applied price for each item in input3
rspec ./spec/purchase_spec.rb:127 # Purchase#print_receipt total taxes and price for input3
```
