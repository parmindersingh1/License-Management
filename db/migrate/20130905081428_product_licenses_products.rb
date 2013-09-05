class ProductLicensesProducts < ActiveRecord::Migration
  def up
    create_table :product_licenses_products do |t|
      t.references :product
      t.references :product_license
    end
  end

  def down
    drop_table :product_licenses_products
  end
end
