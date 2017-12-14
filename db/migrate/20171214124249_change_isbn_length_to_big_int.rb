class ChangeIsbnLengthToBigInt < ActiveRecord::Migration[5.1]
  def change
    change_column :books, :isbn, :bigint
  end
end
