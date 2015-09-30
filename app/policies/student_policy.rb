class StudentPolicy < ApplicationPolicy

  def create?
    return user.role.rights.where("value = 'create_student'").any?
  end

  def mark_attendence?
    return user.role.rights.where("value = 'create_sattendence'").any?
  end

  def give_discount?
    return user.role.rights.where("value = 'update_fee'").any?
  end

end