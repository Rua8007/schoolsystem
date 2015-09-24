class RightsController < ApplicationController

  def new
    @teacher_rights = Right.where(name: 'teacher')
    @parent_rights = Right.where(name: 'parent')
    @admin_rights = Right.where(name: 'admin')
    @accountant_rights = Right.where(name: 'accountant')
    @student_rights = Right.where(name: 'student')
  end

  def create

  end

  def destroy

  end

  def edit

    if params[:id] == 'teacher'
      @role = 'teacher'
      @teacher_rights = Right.where(name: 'teacher')
    elsif params[:id] == 'admin'
      @role = 'admin'
      @rights = Right.where(name: 'admin')
    elsif params[:id] == 'accountant'
      @role = 'accountant'
      @rights = Right.where(name: 'accountant')
    elsif params[:id] == 'parent'
      @role = 'parent'
      @rights = Right.where(name: 'parent')
    elsif params[:id] == 'student'
      @role = 'student'
      @rights = Right.where(name: 'student')
    end

  end

  def update

  end

  def add_roles
    # return render json: params
    role = params[:role]
    if params[:student].present?
      temp = params[:student].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:employee].present?
      temp = params[:employee].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:leave].present?
      temp = params[:leave].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:sattendence].present?
      temp = params[:sattendence].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:eattendence].present?
      temp = params[:eattendence].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:prequest].present?
      temp = params[:prequest].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:fee].present?
      temp = params[:fee].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:subject].present?
      temp = params[:subject].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:grade].present?
      temp = params[:grade].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:transport].present?
      temp = params[:transport].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:bookshop].present?
      temp = params[:bookshop].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end

    if params[:exam].present?
      temp = params[:exam].keys
      temp.each do |t|
        right = Right.new
        right.name = role
        right.value = t
        right.save
        return render json: right
      end
    end
  end

end
