class AddAddressToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :address, :string
  end
end
