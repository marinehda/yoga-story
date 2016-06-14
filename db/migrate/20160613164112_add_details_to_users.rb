class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :zipcode, :string
    add_column :users, :country, :string
    add_column :users, :phone, :string
    add_column :users, :gender, :string
    add_column :users, :birth_date, :date
    add_column :users, :photo, :string
    add_column :users, :is_admin, :boolean
    add_column :users, :yoga_type, :string
    add_column :users, :level, :string
  end
end
