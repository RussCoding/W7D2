class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :log_in_user!, :log_out_user!
    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        current_user != nil
    end

    def log_in_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def log_out_user!
        session[:session_token] = nil
        user.reset_session_token!
    end
end
