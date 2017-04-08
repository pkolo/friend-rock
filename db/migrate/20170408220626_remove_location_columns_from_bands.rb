class RemoveLocationColumnsFromBands < ActiveRecord::Migration[5.0]
  def change
    remove_column :bands, :city
    remove_column :bands, :state
    remove_column :bands, :country
  end
end
