require 'spec_helper'

describe ProductLicense do


   product = Product.create(name: "testproduct",
                     release_date: Date.today , version: "1.0")
   before { @productlicense = product.product_licenses.new(license_key: "Loremipsum") }

  subject { @productlicense }
  
  it { should respond_to(:license_key) }
  it { should respond_to(:product_id) }
  it { should respond_to(:product) }
  it { should respond_to(:allow_regeneration) }
  it { should respond_to(:calculated_key) }
  it { should respond_to(:created_by) }
  it { should respond_to(:email) }
  it { should respond_to(:is_assigned) }
  it { should respond_to(:is_created) }
  it { should respond_to(:is_deleted) }
  it { should respond_to(:machine_id) }
  it { should respond_to(:reset_counter) }
  it { should respond_to(:updated_by) }
  it { should respond_to(:updated_date) } 
  its(:product_id) { should eq product.id }
  
  describe "when product_id is not present" do
    before { @productlicense.product_id = nil }
    it { should_not be_valid }
  end
  
  describe "when product_id is not present" do
    before { @productlicense.product_id = nil }
    it { should_not be_valid }
  end
  
  describe "when license key is not present" do
    before { @productlicense.license_key = nil }
    it { should_not be_valid }
  end
end