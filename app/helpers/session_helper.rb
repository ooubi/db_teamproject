module SessionHelper
  def log_in(user)
    print "hello!"
    session[:login_id] = user.login_id
  end

  def current_user
    @current_user ||= User.find_by(:login_id => session[:login_id])
  end

  def logged_in?
    @current_user != nil
  end

  def log_out
    session.delete(:login_id)
    @current_user = nil
  end
end
