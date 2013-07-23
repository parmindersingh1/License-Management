class CreateProductLicenses < ActiveRecord::Migration
  def change
    create_table :product_licenses do |t|
      t.string :license_key
      t.string :calculated_key
      t.string :email
      t.string :machine_id
      t.date :expiry_date
      t.integer :reset_counter, :default => 0
      t.boolean :allow_regeneration, :default => false
      t.boolean :is_assigned, :default => false
      t.boolean :is_created, :default => false
      t.boolean :is_deleted, :default => false
      t.string :created_by
      t.string :updated_by
      t.date :updated_date

      t.timestamps
    end
  end
end
