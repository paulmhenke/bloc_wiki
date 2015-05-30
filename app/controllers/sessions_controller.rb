class SessionsController < ApplicationController
  
  def new
  end
  
  def create
      user = User.find_by_email(params[:email].downcase)
      if user && user.authenticate(params[:password])
        if user.email_confirmed
          session[:user_id] = user.id
          flash[:notice] = "You have logged in!"
          redirect_to root_url
        else
          flash[:notice] = 'Please activate your account by following the 
          instructions in the account confirmation email you received to proceed'
          render 'new'
        end
      else
        flash.now[:error] = 'Invalid email/password combination' 
        render 'new'
      end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out"
  end
  
end
