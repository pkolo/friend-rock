class TagsController < ApplicationController

  def show
    @tag_name = params[:tag_name]
    @list = Band.tagged_with(params[:tag_name])
  end

end
