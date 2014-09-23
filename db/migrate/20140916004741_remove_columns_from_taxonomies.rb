class RemoveColumnsFromTaxonomies < ActiveRecord::Migration
  def change
     remove_column :taxonomies, :count
  end
end
