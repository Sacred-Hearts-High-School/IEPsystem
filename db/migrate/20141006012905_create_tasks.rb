class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :taskgroup_id
      t.integer :classroom_id
      t.integer :student_id
      t.integer :teacher_id
      t.integer :post_id
      t.string :title
      t.text :content
      t.string :filename
      t.integer :type
      t.integer :status
      t.text :comment
      t.string :token

      t.timestamps
    end
  end
end
