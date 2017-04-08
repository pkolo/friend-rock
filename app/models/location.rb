class Location < ApplicationRecord
  has_many :bands

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

end
