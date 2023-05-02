class UsersController < ApplicationController
  before_action :find_user_by_id, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      flash[:notice] = 'Successful registration'
      redirect_to root_path
    else
      flash[:notice] = @user.errors.messages
      redirect_to new_user_path
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Update successful'
      redirect_to edit_user_path
    else
      flash[:notice] = "Could not update data"
      redirect_to edit_user_path
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user] = @user.id
      flash.notice = 'Successful login'
      redirect_to root_path
    else
      flash.notice = "Login failed"
      redirect_to new_user_path
    end
  end

  def logout
    session.destroy
    flash.notice = 'Successful logout'
    redirect_to new_user_path
  end

  private
    def find_user_by_id
      if @user.nil?
        @user = User.find params[:id]
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
