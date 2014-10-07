class CreateTaskgroups < ActiveRecord::Migration
  def change
    create_table :taskgroups do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
