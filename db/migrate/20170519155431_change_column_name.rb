class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :sources, :type_form, :typo_form
  end
end
