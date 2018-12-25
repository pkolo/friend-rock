class Project < ApplicationRecord
  belongs_to :user
  has_many :project_memberships
  has_many :members, through: :project_memberships, source: :user

  alias_attribute :owner, :user
end
