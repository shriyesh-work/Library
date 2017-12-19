class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname, limit: 35
      t.string :lastname, limit: 35
      t.string :email, limit: 128, index: true
      t.string :password, limit: 128
      t.boolean :is_admin, null: false, default: false
      t.timestamps
    end
  end
end
