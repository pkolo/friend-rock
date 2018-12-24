class ChangeReferencesOnProjectMemberships < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_memberships, :project, index: true, foreign_key: true
    remove_reference :project_memberships, :band, index: true
  end
end
