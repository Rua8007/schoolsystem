require 'mustache'

class StudentSms < Mustache
  self.path = File.dirname(__FILE__)

  def initialize(student=nil)
    @student = student
  end

  def student
    @student
  end

end