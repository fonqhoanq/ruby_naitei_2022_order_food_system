class ApplicationController < ActionController::Base
  before_action :check_role_user, :set_locale

  private
  def check_role_user; end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
