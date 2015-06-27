class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user).group_by { |w| w.private? ? "private" : "public" }
    @user = current_user
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    @collaborators = @wiki.users 
    @owner = @wiki.owner
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
  
  def add_collaborator
    @wiki = Wiki.find(params[:id])
    @collaborator = User.find(params[:collaborator_id])
    @wiki.users << @collaborator
    flash[:notice] = "#{@collaborator.name} has been added as a collaborator."
    redirect_to edit_wiki_path(@wiki)
  end
  
  def remove_collaborator
    @wiki = Wiki.find(params[:id])
    @collaborator = User.find(params[:collaborator_id])
    @wiki.users.delete(@collaborator)
    flash[:notice] = "#{@collaborator.name} has been removed as a collaborator."
    redirect_to edit_wiki_path(@wiki)
  end
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
  
end
