class Product < ActiveRecord::Base
  attr_accessible :name, :release_date, :version
end
