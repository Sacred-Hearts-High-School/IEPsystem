class RemoveIdColumnsFromPosts < ActiveRecord::Migration
  def change
     remove_column :posts, :student_id
     remove_column :posts, :classroom_id
     add_column :posts, :taxonomies, :string
  end
end
