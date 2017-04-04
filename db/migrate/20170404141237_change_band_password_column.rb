class ChangeBandPasswordColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :bands, :password_hash, :string
    add_column :bands, :password_digest, :string, null: false
  end
end
