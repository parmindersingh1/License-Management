class AddIsDeletedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_deleted, :boolean
  end
end
