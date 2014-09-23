class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :no
      t.string :pid
      t.string :email
      t.integer :stu_type
      t.string :stu_class
      t.text :disable_desc
      t.string :father
      t.string :father_phone
      t.string :mother
      t.string :mother_phone
      t.string :phone

      t.timestamps
    end
  end
end
