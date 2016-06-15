class ChangeTeacherToSti < ActiveRecord::Migration

  def up
    add_column :users, :experience, :integer
    add_column :users, :description, :text
    add_column :users, :type, :string
    remove_foreign_key :teachers, :users
    remove_foreign_key :lessons, :teachers
    add_foreign_key :lessons, :users, column: :teacher_id
    drop_table :teachers
  end

  def down
    remove_column :users, :experience
    add_column :users, :description
    create_table :teachers do |t|
      t.integer :experience
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end

end
