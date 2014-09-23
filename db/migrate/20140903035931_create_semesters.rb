class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :year
      t.integer :semester
      t.string :name

      t.timestamps
    end
  end
end
