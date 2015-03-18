class UsersController < ApplicationController
  
   def user_param
    params.require(:user).permit(:username,:password)
  end
end
