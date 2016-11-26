class UsersController < ApplicationController
  def index
    if current_user.role.rights.where(value: "users").blank?
      flash[:alert] =  'Sorry! You are not authorized.'
      redirect_to root_path
    else
      @users = []
      if params[:role]
        @role = params[:role]
        @users = Role.find_by_name(params[:role]).users
      else
        Role.where("name != 'Teacher' AND name != 'Parent'").each do |role|
          @users += role.users
        end
      end
      respond_to do |format|
        format.html
        format.csv { send_data User.to_csv, filename: "users-of-alomam.csv" }
        format.pdf{
          @title = 'Users List'
          render pdf: 'users.pdf', template: 'users/index.pdf.erb',  layout: 'pdf.html.erb',
                 margin: { top: 30, bottom: 11, left: 5, right: 5},
                 header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
                 footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
        }
      end
    end
  end

  def switch_user
    user = User.find(params[:user_id])
    sign_in(user)
    redirect_to root_path, notice: "User has been switched...!!!"
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.where.not(name: 'superuser')
  end

  def update
    if params[:commit] == 'Update Password'
      if params[:user][:password] != params[:user][:password_confirmation]
        redirect_to :back, alert: "Password and confirm password does not match"
      end
    end
    u = User.find(params[:id])
    email = u.email
    u.update_attributes(user_params)
    if u.role.name == 'Teacher'
      u = User.find(params[:id])
      emp = Employee.find_by_email(email)
      emp.email = u.email
      emp.save
    end
    redirect_to users_path, notice: "User Updated Successfully"
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
      u.is_active = true
      u.save
      redirect_to users_path, notice: "User Created Successfully"

    else
      redirect_to :back, alert: "Password and Password Confirmation Does not match"
    end
  end

  def enable
    u = User.find(params[:id])
    if params[:status] == 'enable'
      u.is_active = true
    else
      u.is_active = false
    end
    u.save
    redirect_to users_path, notice: "User Status Updated Successfully"
  end

  def password
    @user = User.find(params[:id])
  end

  def enable_or_disable_users
    ids = params[:ids].split(',')
    if ids.present? and params[:value].present?
      value = params[:value] == 'true' ? true : false
      ids.each do |id|
        user = User.find id rescue nil
        user.update_attribute(:is_active,  value) if user.present?
      end
      message_value = value ? 'Enabled' : 'Disabled'
      flash[:notice] = "Users #{message_value} Successfully."
    else
      flash[:notice] = 'Sorry, something bad happened.'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role_id)
    end
end
