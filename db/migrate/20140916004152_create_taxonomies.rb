class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.string :name
      t.integer :post_id
      t.integer :count

      t.timestamps
    end
  end
end
