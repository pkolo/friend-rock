class BandsController < ApplicationController

  def show
    @band = Band.find(params[:id])
    @friends = @band.friends_list
    @sent_requests = @band.get_band_list(@band.sent_requests)
    @received_requests = @band.get_band_list(@band.received_requests)
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      log_in @band
      redirect_to @band
    else
      render 'new'
    end
  end

  def search
    query = params[:q]
    if query.present?
      @bands = Band.name_search(query[:name])
    else
      @bands = Band.all
    end

    render 'search'
  end

protected
  def band_params
    params.require(:band).permit(:email, :name, :password, :tag_list, :genre_list)
  end

end
