class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :version
      t.date :release_date

      t.timestamps
    end
  end
end
