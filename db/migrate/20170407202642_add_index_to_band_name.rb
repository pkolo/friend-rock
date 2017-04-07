class AddIndexToBandName < ActiveRecord::Migration[5.0]
  def change
    add_index :bands, :name
  end
end
