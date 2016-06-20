class RemoveCountryFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :country
  end
end
