class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :get_leave_requests_count

  before_filter :authenticate_user!

  def get_leave_requests_count
    @leave_requests_count = Leave.where(approved: false).count
  end
end
