class CreateSymptoms < ActiveRecord::Migration[6.1]
  def change
    create_table :symptoms do |t|
      t.string :title
      t.text :note
      t.date :date

      t.timestamps
    end
  end
end
