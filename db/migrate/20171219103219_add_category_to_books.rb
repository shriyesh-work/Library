class AddCategoryToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :category_id, :bigint
  end
end
