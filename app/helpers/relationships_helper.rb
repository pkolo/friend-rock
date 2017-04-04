module RelationshipsHelper

  def relationship_exists?(band, other_band)
    Relationship.where(band_one: band, band_two: other_band).or(Relationship.where(band_one: other_band, band_two: band)).any?
  end

end
