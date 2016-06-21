class AddDetailsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :hours, :integer
    add_column :lessons, :minutes, :integer
  end
end
