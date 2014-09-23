class FixColumnName < ActiveRecord::Migration
  def change
     # type 是保留字，所以需要修改。
     rename_column :t_in_cs, :type, :role
  end
end
