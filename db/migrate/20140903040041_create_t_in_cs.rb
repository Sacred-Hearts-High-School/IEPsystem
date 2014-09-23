class CreateTInCs < ActiveRecord::Migration
  def change
    create_table :t_in_cs do |t|
      t.integer :classroom_id
      t.integer :teacher_id
      t.string :subject
      t.integer :type

      t.timestamps
    end
  end
end
