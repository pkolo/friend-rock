class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :band_one_id, null: false
      t.integer :band_two_id, null: false
      t.integer :action_band_id, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
