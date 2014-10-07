class FixColumnNameType < ActiveRecord::Migration
  def change
     rename_column :attachments, :type, :genus
     rename_column :tasks, :type, :genus
  end
end
