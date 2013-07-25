class Product < ActiveRecord::Base
  attr_accessible :name, :release_date, :version
  belongs_to :product_licenses
end
