class AddYogaTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :yoga_type, :string, array: true, default: []
  end
end
