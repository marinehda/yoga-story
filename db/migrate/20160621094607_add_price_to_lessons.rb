class AddPriceToLessons < ActiveRecord::Migration
  def change
    add_monetize :lessons, :price, currency: { present: false }
  end
end
