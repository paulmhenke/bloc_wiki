class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 24.hours.ago
      redirect_to new_password_reset_path, flash[:danger] = "Password Reset has expired."
    elsif @user.update_attributes(password_reset_params)
      redirect_to root_url
    else
      render :edit
    end
  end
  
  private
    def password_reset_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
