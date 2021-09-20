class ChangeTeaTitleToVariety < ActiveRecord::Migration[6.1]
  def change
    rename_column :teas, :title, :variety
  end
end
