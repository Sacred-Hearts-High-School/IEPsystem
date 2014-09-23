class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :teacher_id
      t.integer :student_id
      t.integer :classroom_id
      t.integer :permission

      t.timestamps
    end
  end
end
