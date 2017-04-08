class AddLocationReferenceToBands < ActiveRecord::Migration[5.0]
  def change
    add_reference :bands, :location, index: true
  end
end
