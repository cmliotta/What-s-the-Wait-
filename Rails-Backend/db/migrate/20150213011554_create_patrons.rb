class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_hash

      t.timestamps
    end
  end
end
