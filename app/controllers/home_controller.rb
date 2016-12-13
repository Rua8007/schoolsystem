class HomeController < ApplicationController

  def index

    if current_user.role.name == 'superuser'
      @notifications = Notification.where('created_at >= ?', 1.week.ago).order("created_at desc")
    end
    if current_user.role.name == 'Parent'
      @temp2 = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @parent = @student.parent
      @student_no = @student.rollnumber

      @bridges = Bridge.where(grade_id: @student.grade_id) if @student.present?
    elsif current_user.role.name == 'Teacher'
      @categories = Category.order(:name)
      @departments = Department.order(:name)
      @employee = Employee.find_by_email(current_user.email)
      @bridges = @employee.bridges if @employee.present?
    end
  end

  def notifications
    if current_user.role.name == 'superuser'
      @notifications = Notification.where('created_at >= ?', 1.month.ago).order("created_at desc")
    else
      redirect_to root_path, "You are not authorized to access this page...!!!"
    end
  end

  def alerts
    if current_user.role.rights.where(value: 'view_alerts').any?
      @iqama_expiries = Student.where('to_date("iqamaExpiry", '+"'MM DD YY'"+') BETWEEN ? AND ?',Time.now-30.days,Time.now)
      @new_students = Student.where('created_at > ?', 30.days.ago)
    else
      redirect_to root_path, alert: "Access Dinied"
    end
    # return render json: params
  end

  def timetable
  end

  def sms
    redirect_to root_path, alert: "Sorry! You are not authorized" unless Right.where("role_id = ? and value = 'send_sms'", current_user.role_id ).any?
  end

  def sendsms
    # return render json: params

    if params[:email]
      EmailService.new(params).delay.send_email
    end

    if params[:sms]
      SmsService.new(params).delay.send_sms
    end
    flash[:notice] = 'Notifications sent.'
    redirect_to home_sms_path()
  end

  def backups
    if current_user.role.rights.find_by_value("access_backups").nil? || session[:confirm_password] == false
      
      puts "========backups nh dkhany aya========== "
      puts current_user.role.rights.find_by_value("access_backups").nil?
      puts session[:confirm_password]
      puts
      redirect_to root_path, alert: "Sorry! You are not authorized"
    else
      puts "========idhr bhi aya hai backups dkhnay========== "
      puts 
      puts
      puts
      if session[:confirm_password] == true
        session[:confirm_password] = false
      end
      s3 = Aws::S3::Client.new
      s4 = Aws::S3::Resource.new(
          :access_key_id     => ENV["AMAZON_ACCESS_KEY"],
          :secret_access_key => ENV["AMAZON_SECRET_KEY"]
        )
      resp = s3.list_objects(bucket: 'alomambackups')
      @backups = []

      resp.contents.last(10).each do |object|
        name = object.key.to_s.split('/')[2]
        # s3.get_object({ bucket:'alomam', key: object.key } ,
        #   target: Rails.root.join("s3_downloads/#{name}.tar"))
        @backups<< {
          key: object.key,
          name: name,
          url: s4.bucket('alomambackups').object(object.key).presigned_url(:get, expires_in: 3600)
        }
      end
    end
  end

  def restore_backup
    if !current_user.role.rights.where(value: "access_backups").any?
      redirect_to root_path, alert: "Sorry! You are not authorized"
    else
      s3 = Aws::S3::Client.new
      name = params[:name]
      s3.get_object({ bucket:'alomambackups', key: params[:key] },
        target: Rails.root.join("s3_downloads/#{name}.tar"))

      `tar -xvf ~/schoolsystem/s3_downloads/#{name}.tar` #extract backup tar file
      `rake environment db:drop` #drop existing database
      `rake db:create` #create database
      `PGPASSWORD=postgres psql schoolsystem_production postgres < miguest_backup/databases/PostgreSQL.sql` #restore
      redirect_to home_backups_path, notice: 'Backup Restored Successfully..!!!'
    end
  end

  def create_backup
    if !current_user.role.rights.where(value: "access_backups").any?
      redirect_to root_path, alert: "Sorry! You are not authorized"
    else
      puts "========idhr to aya tha backup create krny========== "
      puts 
      puts
      puts
      Bundler.with_clean_env do
        `backup perform --trigger miguest_backup`
      end
      session[:confirm_password] = true
      redirect_to home_backups_path, notice: 'Backup Created Successfully..!!!'
    end
  end

  def confirm_password
    @redirection = params[:redirection]
    # return render json: params
  end

  def confirm_admin
    # return render json: params
    user = User.find_by_email(params[:email])
    if user && user.valid_password?(params[:password])
      session[:confirm_password] = true
      if params[:redirection] == 'promote'
        redirect_to promote_grades_path(confirmed: true), notice: 'Access Granted...!!!'
      elsif params[:redirection] == 'backup'
        redirect_to home_backups_path(confirmed: true), notice: 'Access Granted...!!!'
      end
    else
      redirect_to :back , alert: 'Invalid Admin Credentials'
    end
  end
end