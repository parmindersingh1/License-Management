class Key < ActiveRecord::Base
  attr_accessible :generated_key
  validates :generated_key,uniqueness: { case_sensitive: false }
end
