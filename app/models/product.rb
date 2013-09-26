class Product < ActiveRecord::Base
  attr_accessible :name, :release_date, :version,:is_deleted

  validates :name, :release_date, :version, :presence=>true    
  validates :name , :uniqueness=> true
  has_and_belongs_to_many :product_licenses     
 
end
