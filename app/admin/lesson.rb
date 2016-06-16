ActiveAdmin.register Lesson do
  index do
    selectable_column
    column :id
    column :name
    column :created_at
    column :start_date
    column :end_date
    actions
  end

  permit_params :name, :start_date, :end_date
end
