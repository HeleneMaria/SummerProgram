class StaticPagesController < ApplicationController
   before_filter :signed_in_user, only: [:home]
  
  def home
  end
  
  def about
  end
  
 private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
end
