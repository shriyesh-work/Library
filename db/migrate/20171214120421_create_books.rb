class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name, limit: 128
      t.string :author, limit: 128
      t.integer :isbn 
      t.string :category, limit: 128
    end
  end
end
