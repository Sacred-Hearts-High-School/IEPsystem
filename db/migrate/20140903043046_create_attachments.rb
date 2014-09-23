class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :classroom_id
      t.integer :student_id
      t.integer :teacher_id
      t.integer :post_id
      t.string :title
      t.text :content
      t.string :filename
      t.integer :type
      t.integer :status

      t.timestamps
    end
  end
end
