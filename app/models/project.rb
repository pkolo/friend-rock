class Project < ApplicationRecord
  has_many :project_memberships
  has_many :members, through: :project_memberships, source: :user
end
