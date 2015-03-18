module SessionsHelper
  
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user= user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user) #we want the current_ser to be accessible both in the view and in the controller
    @current_user = user
  end
  
  def current_user #we want the user to persist between different pages
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) # ||= means if the @current_ser is undefined, it's equal to
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
