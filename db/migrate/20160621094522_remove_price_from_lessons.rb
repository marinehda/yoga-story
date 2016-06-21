class RemovePriceFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :price, :integer
  end
end
