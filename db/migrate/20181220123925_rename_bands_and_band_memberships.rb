class RenameBandsAndBandMemberships < ActiveRecord::Migration[5.2]
  def change
    rename_table :bands, :projects
    rename_table :band_memberships, :project_memberships
  end
end
