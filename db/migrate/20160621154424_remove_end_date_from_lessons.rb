class RemoveEndDateFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :end_date, :datetime
  end
end
