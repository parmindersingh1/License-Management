require 'spec_helper'

describe Product do


  before do
    @product = Product.new(name: "testproduct",
                     release_date: Date.today, version: "1.0")
  end

  subject { @product }
  
  it { should respond_to(:name) }
  it { should respond_to(:release_date) }
  it { should respond_to(:version) }
  it { should respond_to(:product_licenses) }
  
  describe "when name is not present" do 
    before { @product.name=" "}
    it { should_not be_valid }
  end
  
  describe "when release date is not present" do 
    before { @product.release_date=" "}
    it { should_not be_valid }
  end
  
  describe "when name is not present" do 
    before { @product.version=" "}
    it { should_not be_valid }
  end
  
  describe "when invalid date" do 
     before { @product.release_date="invalid"}
     it { should_not be_valid }
  end
        
        
end