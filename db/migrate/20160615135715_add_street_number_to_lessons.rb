class AddStreetNumberToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :street_number, :string
  end
end
