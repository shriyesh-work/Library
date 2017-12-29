class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :user
      t.references :book
      t.boolean :returned, default: false
      t.timestamps
    end
  end
end
