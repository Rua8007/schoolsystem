class HomeController < ApplicationController

  def index

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

  def timetable
  end

  def sms
    redirect_to root_path unless Right.where("role_id = ? and value = 'send_sms'", current_user.role_id ).any?
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
    s3 = Aws::S3::Client.new
    s4 = Aws::S3::Resource.new(
        :access_key_id     => ENV["AMAZON_ACCESS_KEY"],
        :secret_access_key => ENV["AMAZON_SECRET_KEY"]
      )
    resp = s3.list_objects(bucket: 'alomam')
    @backups = []

    resp.contents.last(10).each do |object|
      name = object.key.to_s.split('/')[2]
      # s3.get_object({ bucket:'alomam', key: object.key } ,
      #   target: Rails.root.join("s3_downloads/#{name}.tar"))
      @backups<< {
        key: object.key,
        name: name,
        url: s4.bucket('alomam').object(object.key).presigned_url(:get, expires_in: 3600)
      }
    end
  end

  def restore_backup
    s3 = Aws::S3::Client.new
    name = params[:name]
    s3.get_object({ bucket:'alomam', key: params[:key] },
      target: Rails.root.join("s3_downloads/#{name}.tar"))
    puts "downloading is done"
    puts "downloading is done"
    puts "downloading is done"
    puts "downloading is done"
    `tar -xvf ~/schoolsystem/s3_downloads/#{name}.tar`
    `dropdb schoolsystem_development`
    `psql -U postgres -d schoolsystem_development -f miguest_backup/databases/PostgreSQL.sql`
    redirect_to root_path, notice: 'Backup Restored Successfully..!!!'
  end

  def create_backup
    `backup perform --trigger miguest_backup`
    redirect_to home_backups_path, notice: 'Backup Created Successfully..!!!'
  end
end