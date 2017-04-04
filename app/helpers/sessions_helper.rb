module SessionsHelper

  def log_in(band)
    session[:band_id] = band.id
  end

  def current_band
    @current_band ||= Band.find_by(id: session[:band_id])
  end

  def logged_in?
    !current_band.nil?
  end

  def log_out
    session.delete(:band_id)
    @current_band = nil
  end

end
