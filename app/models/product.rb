class Product < ActiveRecord::Base
  attr_accessible :name, :release_date, :version
  validates :name, :release_date, :version, :presence=>true   
  validate :release_date_is_valid_datetime
  has_many :product_licenses
  
    
  def release_date_is_valid_datetime
    errors.add(:release_date, 'must be a valid datetime') if ((DateTime.parse(release_date) rescue ArgumentError) == ArgumentError)
  end
end
