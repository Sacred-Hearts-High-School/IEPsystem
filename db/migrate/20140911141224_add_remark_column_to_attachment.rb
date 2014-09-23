class AddRemarkColumnToAttachment < ActiveRecord::Migration
  def change
      add_column :attachments, :remark, :string
  end
end
