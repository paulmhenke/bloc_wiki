class UsersController < ApplicationController
    
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed up!"
      redirect_to root_url
    else 
      flash[:danger] = "Something went wrong. Try again."
      render "new"
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
        
end
