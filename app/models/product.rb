class Product < ActiveRecord::Base
  attr_accessible :name, :release_date, :version

  validates :name, :release_date, :version, :presence=>true    
  has_and_belongs_to_many :product_licenses     
 
end
