class Band < ApplicationRecord
  has_secure_password
  acts_as_taggable
  acts_as_taggable_on :genres

  has_many :relationships, foreign_key: :band_one_id

  has_many :friendships, -> { where("status = :code", code: 1) }, class_name: Relationship, foreign_key: :band_one_id

  has_many :sent_requests, ->(band) { where("action_band_id = :id AND status = :code", id: band.id, code: 0) }, class_name: Relationship, foreign_key: :band_one_id

  has_many :received_requests, ->(band) { where("action_band_id != :id AND status = :code", id: band.id, code: 0) }, class_name: Relationship, foreign_key: :band_one_id

  has_many :related_bands, through: :relationships, source: :band_two, dependent: :destroy
  has_many :friends, through: :friendships, source: :band_two
  has_many :sent_requests_to, through: :sent_requests, source: :band_two
  has_many :received_requests_from, through: :received_requests, source: :band_two

  def self.name_search(query)
    self.where("similarity(name, ?) > 0.3", query).order("similarity(name, #{ActiveRecord::Base.connection.quote(query)}) DESC")
  end

  def address
    [city, state, country].compact.join(', ')
  end

  def short_address
    if self.country == "USA" || self.country == "United States"
      [city, state].compact.join(', ')
    else
      self.address
    end
  end

  def all_related_bands
    related_bands.or(more_related_bands)
  end

  def friends_list
    self.get_band_list(self.friendships)
  end

  def get_mutual_friends(other_band)
    self.friends_list & other_band.friends_list
  end

  def get_other_friends(other_band)
    other_band.friends_list - (self.get_mutual_friends(other_band))
  end

  def relationship_with(other_band)
    relationship = self.find_relationship(other_band)
    if relationship
      if relationship.status == 0
        "Pending"
      elsif relationship.status == 1
        "Friends"
      end
    else
      "Not Friends"
    end
  end

  def find_relationship(other_band)
    Relationship.where(band_one: self, band_two: other_band).or(Relationship.where(band_one: other_band, band_two: self)).first
  end

  def get_band_list(relationships)
    list = relationships.inject([]) do |memo, relationship|
      memo << self.get_other_band(relationship)
    end
    list
  end

  def get_other_band(relationship)
    if relationship.band_one == self
      relationship.band_two
    else
      relationship.band_one
    end
  end

end
