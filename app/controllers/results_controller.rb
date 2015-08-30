class ResultsController < ApplicationController
  def new
  	@result = Result.new
  end

  def create
  	@result = Result.create(result_params)
  	redirect_to upload_marksheet_path(@result.id)
  end

  def index
  	@results = Result.all
  end

  private
  	def result_params
      params.require(:result).permit(:exam_id, :bridge_id)
  	end
end
