class Band < ApplicationRecord
  has_secure_password

  has_many :relationships, foreign_key: :band_one_id
  has_many :more_relationships, class_name: Relationship, foreign_key: :band_two_id

  def all_relationships
    (self.relationships + self.more_relationships)
  end
end
