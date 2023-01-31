module Authentication
  extend ActiveSupport::Concern

  included do
    private # we could move it to separate concern

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]).decorate if session[:user_id].present?
    end

    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    helper_method :current_user, :user_signed_in? # make this methods as helpers
  end
end
