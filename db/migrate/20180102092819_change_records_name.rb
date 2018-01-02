class ChangeRecordsName < ActiveRecord::Migration[5.1]
  def change
    rename_table :records, :library_records
  end
end
