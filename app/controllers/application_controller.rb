class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  before_action :set_locale

  private
  def render_404
    render file: Rails.root.join("public", "404.html").to_s, layout: false,
           status: :not_found
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def require_login
    return if user_signed_in?

    flash[:danger] = t ".require_login"
    redirect_to new_user_session_path
  end

  def set_ransack_auth_object
    current_user&.admin? ? :admin : nil
  end
end
