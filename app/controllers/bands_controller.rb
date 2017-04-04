class BandsController < ApplicationController

  def show
    @band = Band.find(params[:id])
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

protected
  def band_params
    params.require(:band).permit(:email, :name, :password)
  end

end
