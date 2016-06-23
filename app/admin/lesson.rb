ActiveAdmin.register Lesson do
  index do
    selectable_column
    column :id
    column :name
    column :created_at
    column :start_date
    column :hours
    column :minutes
    column :teacher_id
    actions
  end

  permit_params :name, :start_date, :hours, :minutes, :address, :street_number, :street, :city, :zip_code, :min_students, :max_students, :description, :price, :location_name, :teacher_id
end
