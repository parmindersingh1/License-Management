class Product < ActiveRecord::Base
  attr_accessible :name, :release_date, :version
  has_many :product_licenses
end
