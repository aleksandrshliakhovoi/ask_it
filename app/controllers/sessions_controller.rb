class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new # just direct to the form GET request
  end

  def create
    # render plain: params.to_yaml
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password]) # if email nil it will be an error but now only false
      sign_in user
      # session established current_user available
      flash[:success] = "Welcome back, #{current_user.name_or_email}!"
      redirect_to root_path
    else
      flash[:warning] = "Incorrect email or password"
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "See you later"
    redirect_to root_path
  end
end
