class ApplicationController < ActionController::Base
  before_action :find_user

  private
    def find_user
      if session[:user]
        @user = User.find session[:user] 
      end
    end
end
