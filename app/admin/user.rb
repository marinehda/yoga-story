ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :created_at
    column :email
    column :is_admin
    actions
  end

  form do |f|
    f.inputs "Identity" do
      f.input :first_name
      f.input :last_name
      f.input :email
    end
    f.inputs "Admin" do
      f.input :is_admin
    end
    f.actions
  end

  permit_params :first_name, :last_name, :email, :is_admin
end
