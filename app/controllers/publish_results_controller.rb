class PublishResultsController < ApplicationController

  include PublishResultsHelper

  def select_class
    if current_user.role.rights.where(value: 'publish_results').any?
    else
      redirect_to root_path, alert: "Not Authorized...!!!"
    end
    @batch = Batch.last
    @classes = Grade.where.not(section: nil)
    @classes = @classes.where(batch_id: @batch.id).sort {|x,y| x.full_name <=> y.full_name }
  end

  def publish_result
    @class = Grade.find(params[:class_id])
    @batch = Batch.find(params[:batch_id])
    Notification.create(user_id: current_user.id, activity: "Published Results for #{@class.full_name}"  )

    @message = publish_class_result(@batch, @class)
  end

  def hide_result
    @class = Grade.find(params[:class_id])
    @batch = Batch.find(params[:batch_id])
    Notification.create(user_id: current_user.id, activity: "Un-Published Results for #{@class.full_name}"  )

    @message = hide_class_result(@batch, @class)
  end

  def publish_all
    @batch = Batch.find(params[:batch_id])
    @classes = Grade.where.not(section: nil).where(batch_id: @batch.id)
    if @classes.present?
      Notification.create(user_id: current_user.id, activity: "Published Results for All Classes"  )
      @classes.each do |klass|
        flash[:notice] = publish_class_result(@batch, klass)
      end
    else
      flash[:notice] = 'No Classes Present For This Batch.'
    end
    redirect_to select_class_to_publish_path
  end

  def hide_all
    @batch = Batch.find(params[:batch_id])
    @classes = Grade.where.not(section: nil).where(batch_id: @batch.id)
    if @classes.present?
      Notification.create(user_id: current_user.id, activity: "Un-Published Results for All Classes"  )
      @classes.each do |klass|
        flash[:notice] = hide_class_result(@batch, klass)
      end
    else
      flash[:notice] = 'No Classes Present For This Batch.'
    end
    redirect_to select_class_to_publish_path
  end

  protected

  def publish_class_result(batch, klass)
    publish_result = PublishResult.find_or_create_by(class_id: klass.id, batch_id: batch.id)
    publish_result.publish = true
    if publish_result.save
      get_report_card_urls(klass, batch)
      msg = 'Results Published Successfully.'
    else
      msg = 'Sorry something went bad. Please try again.'
    end
    msg
  end

  def hide_class_result(batch, klass)
    publish_result = PublishResult.find_by(class_id: klass.id, batch_id: batch.id)
    if publish_result.present?
      publish_result.publish = false
      if publish_result.save
        delete_report_card_urls(klass, batch)
        msg = 'Results UnPublished Successfully.'
      else
        msg = 'Sorry something went bad. Please try again.'
      end
      msg
    end
  end

end