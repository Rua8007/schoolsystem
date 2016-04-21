class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :null_session

  before_filter :get_leave_requests_count

  before_filter :authenticate_user!, :set_locale

  layout :layout_by_resource

  # rescue_from ActiveRecord::RecordNotFound do
  # flash[:warning] = 'Resource not found.'
  # redirect_back_or root_path
#end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end


  def layout_by_resource
    if devise_controller? && resource_name == :user
      'login'
    else
      'application'
    end
  end


  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def get_leave_requests_count
    @leave_requests_count = Leave.where(approved: nil).count
    @year_plan = YearPlan.first
  end

  def default_url_options(options = {})
    { :locale => I18n.locale }
  end
end
