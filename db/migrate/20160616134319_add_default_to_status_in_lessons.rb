class AddDefaultToStatusInLessons < ActiveRecord::Migration
  def change
    change_column_default(:lessons, :status, 'confirmed')
  end
end
