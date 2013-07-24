class ProductLicense < ActiveRecord::Base
  attr_accessible :allow_regeneration, :calculated_key, :created_by, :email, :expiry_date, :is_assigned, :is_created, :is_deleted, :license_key, :machine_id, :reset_counter, :updated_by, :updated_date
  validates :license_key,uniqueness: { case_sensitive: false }
end
