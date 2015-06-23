class WikisController < ApplicationController

  def index
    #will need to edit to account for public/private
    @wikis = Wiki.visible_to(current_user).group_by { |w| w.private? ? "private" : "public" }
    @user = current_user
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = current_user.wikis.new(wiki_params) #creates collaboration
    @wiki.owner = current_user #sets owner
    if @wiki.save
      redirect_to wikis_path, notice: "Your wiki was saved successfully."
    else flash[:error] = "There was an error. Please try again."
      render :new
    end
  end
    
  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      redirect_to @wiki, notice: "Wiki updated successfully"
    else flash[:error] = "There was an error updating. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Wiki successfully deleted"
      redirect_to wikis_path
    else flash[:error] = "There was an error deleting this wiki. Please try again."
      render :show
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
