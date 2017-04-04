module BandsHelper

  def get_band_list(relationships)
    list = self.relationships.inject([]) do |memo, relationship|
      memo << get_other_band(relationship)
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
