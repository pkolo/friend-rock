class CreateBandMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :band_memberships do |t|
      t.references :user, foreign_key: true, null: false
      t.references :band, foreign_key: true, null: false
      t.string :role
      t.datetime :joined_on

      t.timestamps
    end
  end
end
