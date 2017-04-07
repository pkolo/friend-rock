class RelationshipsController < ApplicationController

  def index
    @band = Band.find(params[:band_id])
    @mutual_friends = current_band.get_mutual_friends(@band)
    @other_friends = current_band.get_other_friends(@band)
  end

  def create
    relationship = Relationship.new(band_one: current_band, band_two: Band.find(params[:id]), action_band: current_band, status: 0)
    if relationship.save
      redirect_to current_band
    else
      redirect_to root_url
    end
  end

  def accept_request
    #Change to relationship validation helper
    relationship = Relationship.where(:band_one_id => params[:id], :band_two_id => current_band.id, :action_band_id => params[:id], :status => 0)

    if relationship.any?
      relationship.first.update_attributes(:action_band => current_band, :status => 1)
      redirect_to current_band
    else
      redirect_to root_url
    end

  end

end
