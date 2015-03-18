class SessionsController < ApplicationController
   def new
    
  end
  
  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authentificate(params[:session][:password])
     #sign in the user and redirect to home page 
    else
      #display an error message
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    
  end

end
