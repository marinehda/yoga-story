class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
      t.string :review_content
      t.string :review_rating
      t.string :status

      t.timestamps null: false
    end
  end
end
