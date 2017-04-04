class RelationshipsController < ApplicationController

  def create
    Relationship.new(band_one: current_band, band_two: Band.find(params[:id]), action_band: current_band, status: 0)
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
