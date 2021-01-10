class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper

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

  def authentication
    redirect_to login_path unless logged_in?
  end
end
