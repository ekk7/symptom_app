class AddRating < ActiveRecord::Migration[6.1]
  def change
    add_column :symptoms, :rating, :decimal
  end
end
