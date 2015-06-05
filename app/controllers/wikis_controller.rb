class WikisController < ApplicationController

  def index
    #will need to edit to account for public/private
    @wikis = Wiki.all
    @user = current_user
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
end
