class AddCopiesToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :copies, :integer, default: 1, after: :isbn
  end
end
