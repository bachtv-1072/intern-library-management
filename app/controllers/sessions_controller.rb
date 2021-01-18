class SessionsController < ApplicationController
  layout "layouts/login/application"

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      flash[:success] = t "sessions.message.sucsess"
      redirect_to root_path
    else
      flash.now[:alert] = t "sessions.message.danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
