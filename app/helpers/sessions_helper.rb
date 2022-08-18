module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def get_cart_count_header
    cart_count = 0
    if session[:cart].present?
      session[:cart]["products"].each_value do |product|
        cart_count += product["count"] if product
      end
    end
    cart_count
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end
end
