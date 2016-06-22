class AddPhotoToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :photo, :string
  end
end
