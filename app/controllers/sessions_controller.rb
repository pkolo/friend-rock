class SessionsController < ApplicationController
  
  def create
    band = Band.find_by(email: params[:sesion][:email])
    if band && band.authenticate(params[:session][:password])
      log_in band
      redirect_to band
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
