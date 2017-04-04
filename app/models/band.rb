class Band < ApplicationRecord
  has_secure_password

  has_many :relationships, foreign_key: :band_one_id
  has_many :more_relationships, class_name: Relationship, foreign_key: :band_two_id

  def all_relationships
    self.relationships.or(self.more_relationships)
  end

  def pending_requests
    self.all_relationships.where(:status => 0)
  end

  def sent_requests
    self.pending_requests.where(:action_band => self)
  end

  def received_requests
    self.pending_requests.where.not(:action_band => self)
  end

  def friendships
    self.all_relationships.where(:status => 1)
  end

  def friends_list
    list = self.friendships.inject([]) do |memo, friendship|
      if friendship.band_one == self
        other_band = friendship.band_two
      else
        other_band = friendship.band_one
      end
      memo << other_band
    end
    list
  end

end
