class AddColumnUserIdToSymptoms < ActiveRecord::Migration[6.1]
  def change
    add_column :symptoms, :user_id, :integer
  end
end
