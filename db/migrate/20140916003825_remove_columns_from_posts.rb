class RemoveColumnsFromPosts < ActiveRecord::Migration
  def change
     remove_column :posts, :teacher_id
  end
end
