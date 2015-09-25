class StudentPolicy < ApplicationPolicy

  def create?
    return Right.where("name = ? and value = 'create_student'", user.role).any?
  end

  def mark_attendence?
    return Right.where("name = ? and value = 'create_sattendence'", user.role).any?
  end

  def give_discount?
    return Right.where("name = ? and value = 'update_fee'", user.role).any?
  end

end