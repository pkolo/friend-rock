class Band < ApplicationRecord
  has_secure_password
  acts_as_taggable
  acts_as_taggable_on :genres

  belongs_to :location

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

  def get_mutual_friends(other_band)
    friends & other_band.friends
  end

  def get_other_friends(other_band)
    other_band.friends - (self.get_mutual_friends(other_band))
  end

  def relationship_with(other_band)
    relationship = self.find_relationship(other_band).first
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
    Relationship.where(band_one: self, band_two: other_band)
  end

end
