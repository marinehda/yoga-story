class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :street
      t.date :start_date
      t.date :end_date
      t.references :teacher, index: true, foreign_key: true
      t.string :status
      t.integer :min_students
      t.integer :max_students
      t.string :name
      t.text :description
      t.integer :price
      t.string :city
      t.string :country
      t.string :zip_code
      t.string :location_name

      t.timestamps null: false
    end
  end
end
