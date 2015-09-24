class StudentPolicy < ApplicationPolicy

  def create?
    if user.role = 'teacher'
      return true
    else
      return false
    end
  end

end