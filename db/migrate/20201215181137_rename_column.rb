class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :symptoms, :cal, :date
  end
end
