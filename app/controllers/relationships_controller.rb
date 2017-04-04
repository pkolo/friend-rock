class RelationshipsController < ApplicationController

  def send_request
    Relationship.new(band_one: current_band, band_two: Band.find(params[:id]), action_band: current_band, status: 0)
  end

  def accept_request
    relationship = Relationship.where(:band_one_id => params[:id], :band_two_id => current_band.id, :action_band_id => params[:id], :status => 0)

    if relationship.any?
      Relationship.update(relationship.first.id, :action_band => current_band, status: 1)
    else
      redirect_to root_url
    end
    
  end

end
