class Band < ApplicationRecord
  has_many :band_memberships
  has_many :members, through: :band_memberships, source: :user
end
