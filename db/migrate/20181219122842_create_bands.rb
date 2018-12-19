class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.string :bio
      t.datetime :started_on

      t.timestamps
    end
  end
end
