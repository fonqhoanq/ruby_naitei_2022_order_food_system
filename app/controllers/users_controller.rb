class UsersController < ApplicationController
  before_action :find_user_by_id, except: %i(new create)
  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash[:error] = t ".update_failed"
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t(".signup_success")
      redirect_to login_path
    else
      flash[:danger] = t(".signup_fail")
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t(".user_not_found")
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :address, :phone_number,
                  :email, :password, :password_confirmation)
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
