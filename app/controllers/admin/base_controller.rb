class Admin::BaseController < ApplicationController
  layout "layouts/admin/application"
  before_action :check_admin

  private

  def check_admin
    return if logged_in? && current_user.admin?

    redirect_to root_path
  end
end
