class RemoveGeocoderColumnsFromBands < ActiveRecord::Migration[5.0]
  def change
    remove_column :bands, :latitude
    remove_column :bands, :longitude
  end
end
