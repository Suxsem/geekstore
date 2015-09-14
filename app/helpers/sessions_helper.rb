module SessionsHelper
    
  # logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # returns the current logged-in user (if any)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end
  
  # returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
  
  # returns true if the user is logged in, false otherwise
  def admin?
    logged_in? && current_user.admin?
  end
  
  # logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # redirects to stored location (or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # stores the URL trying to be accessed
  def store_location(location = nil)
    if location.nil?
      # don't store the url if the request is not a get request
      session[:forwarding_url] = request.fullpath if request.get?
    else
      session[:forwarding_url] = location
    end
  end
  
end
