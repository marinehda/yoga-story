class ChangeDateFormatInLessons < ActiveRecord::Migration
  def up
    change_column :lessons, :start_date, :datetime
    change_column :lessons, :end_date, :datetime
  end

  def down
    change_column :lessons, :start_date, :date
    change_column :lessons, :end_date, :date
  end
end
