class SessionsController < ApplicationController
   def new
    
  end
  
  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
     #sign in the user and redirect to home page 
     sign_in user #defined in SessionsHelper
     redirect_to root_path
    else
      #display an error message
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    sign_out #defined in SessionsHelper
    redirect_to root_path
  end

end
