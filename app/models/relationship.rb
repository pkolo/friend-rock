class Relationship < ApplicationRecord
  belongs_to :band_one, class_name: Band
  belongs_to :band_two, class_name: Band
  belongs_to :action_band, class_name: Band

  validates :band_one, uniqueness: { scope: :band_two }
  validate :cannot_add_self

  private
    def cannot_add_self
      errors.add(:band_two_id, 'You cannot add yourself as a friend.') if band_one_id == band_two_id
    end
end
