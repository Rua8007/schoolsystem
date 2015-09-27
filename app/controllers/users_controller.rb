class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def add_user
    if User.find_by_email(params[:email])
      redirect_to :back, alert: "Email Already taken"
    elsif params[:password] == params[:password_confirmation]
      u = User.new
      u.role_id = params[:role_id]
      u.email = params[:email]
      u.password = params[:password]
      u.password_confirmation = params[:password_confirmation]
      u.save
      redirect_to users_path, notice: "User Created Successfully"

    else
      redirect_to :back, alert: "Password and Password Confirmation Does not match"
    end
  end
end
