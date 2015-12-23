class PublishResultsController < ApplicationController

  include PublishResultsHelper

  def select_class
    @batch = Batch.last
    @classes = Grade.where.not(section: nil)
    @classes = @classes.where(batch_id: @batch.id).sort {|x,y| x.full_name <=> y.full_name }
  end

  def publish_result
    @class = Grade.find(params[:class_id])
    @batch = Batch.find(params[:batch_id])

    publish_result = PublishResult.find_or_create_by(class_id: @class.id, batch_id: @batch.id)
    publish_result.publish = true
    if publish_result.save
      get_report_card_urls(@class, @batch)
      @message = 'Results Published Successfully.'
    else
      @message = 'Sorry something went bad. Please try again.'
    end
  end

  def hide_result
    @class = Grade.find(params[:class_id])
    @batch = Batch.find(params[:batch_id])

    publish_result = PublishResult.find_by(class_id: @class.id, batch_id: @batch.id)
    if publish_result.present?
      publish_result.publish = false
      if publish_result.save
        delete_report_card_urls(@class, @batch)
        @message = 'Results Hidden Successfully.'
      else
        @message = 'Sorry something went bad. Please try again.'
      end
    end
  end

end