class UsersController < ApplicationController
   before_filter :signed_in_user
  def edit
    
  end
  
  def update
    
  end
  
   def user_param
    params.require(:user).permit(:username,:password)
  end
  
   private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
end
