class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname, limit: 35
      t.string :lastname, limit: 35
      t.string :email, limit: 128
      t.string :password, limit: 128
      t.boolean :is_admin
      t.index :email
      t.timestamps
    end
  end
end
