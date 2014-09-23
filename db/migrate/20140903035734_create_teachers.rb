class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :email
      t.string :subject1
      t.string :subject2

      t.timestamps
    end
  end
end
