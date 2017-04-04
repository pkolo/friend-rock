class Relationship < ApplicationRecord
  belongs_to :band_one, class_name: Band
  belongs_to :band_two, class_name: Band
  belongs_to :action_band, class_name: Band

  validate :unique_pair, :on => :create
  validate :cannot_add_self

  private

    def unique_pair
      if self.class.where("(band_one_id = :band_one_id AND band_two_id = :band_two_id) OR (band_one_id = :band_two_id AND band_two_id = :band_one_id)", {:band_one_id => band_one_id, :band_two_id => band_two_id}).exists?
        errors.add(:band_one_id, 'Relationship already exists.')
      end
    end

    def cannot_add_self
      errors.add(:band_two_id, 'You cannot add yourself as a friend.') if band_one_id == band_two_id
    end
end
