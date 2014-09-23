class CreateSInCs < ActiveRecord::Migration
  def change
    create_table :s_in_cs do |t|
      t.integer :classroom_id
      t.integer :student_id

      t.timestamps
    end
  end
end
