class AddUniquenessConstraintToBandPairs < ActiveRecord::Migration[5.0]
  def change
    add_index :relationships, [:band_one_id, :band_two_id], unique: true
  end
end
