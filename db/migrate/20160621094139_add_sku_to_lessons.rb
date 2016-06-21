class AddSkuToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :sku, :string
  end
end
