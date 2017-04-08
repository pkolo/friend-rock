class Relationship < ApplicationRecord
  belongs_to :band_one, class_name: Band
  belongs_to :band_two, class_name: Band
  belongs_to :action_band, class_name: Band

  # validate :unique_pair, :on => :create
  validate :cannot_add_self

  after_create :create_inverse, unless: :has_inverse?
  after_update :update_inverse
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_relationship_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def update_inverse
    relationship = self.class.where(band_one: band_two, band_two: band_one).first
    binding.pry
    if status != relationship.status
      relationship.update_attributes(action_band: action_band, status: status)
    end
  end

  def has_inverse?
    self.class.exists?(inverse_relationship_options)
  end

  def inverses
    self.class.where(inverse_relationship_options)
  end

  def inverse_relationship_options
    { band_two_id: band_one_id, band_one_id: band_two_id, action_band_id: action_band_id, status: status }
  end

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
