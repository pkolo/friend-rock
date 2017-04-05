class AddLocationDataToBand < ActiveRecord::Migration[5.0]
  def change
    add_column :bands, :city, :string, null: false, default: ''
    add_column :bands, :state, :string, null: false, default: ''
    add_column :bands, :country, :string, null: false, default: ''
    add_column :bands, :latitude, :float
    add_column :bands, :longitude, :float
  end
end
