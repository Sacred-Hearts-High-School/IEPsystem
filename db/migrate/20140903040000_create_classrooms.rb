class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :semester_id
      t.integer :num
      t.string :name

      t.timestamps
    end
  end
end
