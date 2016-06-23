class RemoveYogaTypeFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :yoga_type, :string
  end
end
