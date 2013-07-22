class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
<<<<<<< HEAD
      t.string :email
=======
      t.string :eamil
>>>>>>> 5d099974d4188ad9e7f6e8c65b56dd89aafd1c29
      t.string :password

      t.timestamps
    end
  end
end
