class AddTimeStampToBooks < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :books, null: true
  end
end
