class TagsController < ApplicationController

  def show
    @list = Band.tagged_with(params[:tag_name])
  end

end
