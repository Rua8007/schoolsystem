require 'mustache'

class EmployeeEmail < Mustache
  self.path = File.dirname(__FILE__)

  def initialize(employee=nil)
    @employee = employee
  end

  def employee
    @employee
  end

end