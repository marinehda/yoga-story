ActiveAdmin.register Booking do
  index do
    selectable_column
    column :id
    column :status
    column :user_id
    column :lesson_id
    column :review_rating
    column :review_content
    actions
  end

  permit_params :review_content, :review_rating, :user_id, :lesson_id, :status
end
