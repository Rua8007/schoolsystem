class ExamcalendersController < ApplicationController
  before_action :set_examcalender, only: [:show, :edit, :update, :destroy]

  # GET /examcalenders
  # GET /examcalenders.json
  def index
    @examcalenders = Examcalender.all
  end

  # GET /examcalenders/1
  # GET /examcalenders/1.json
  def show
  end

  # GET /examcalenders/new
  def new
    @examcalender = Examcalender.new
    @bridges  = Bridge.all
    @grades = Grade.all
  end

  # GET /examcalenders/1/edit
  def edit
     @bridges  = Bridge.all
    @grades = Grade.all
  end

  # POST /examcalenders
  # POST /examcalenders.json
  def create
    @examcalender = Examcalender.new(examcalender_params)

    respond_to do |format|
      if @examcalender.save
        format.html { redirect_to @examcalender, notice: 'Examcalender was successfully created.' }
        format.json { render :show, status: :created, location: @examcalender }
      else
        format.html { render :new }
        format.json { render json: @examcalender.errors, status: :unprocessable_entity }
      end
    end
  end

  def examdetail
    @grades = Grade.where('section IS NOT NULL').order('name')
  end

  def examdata
    puts '-'*80
    if params[:grade_id].present? && params[:grade_id] != ""
      @exam = []
      Grade.find(params[:grade_id]).bridges.try(:each) do |bri|
        @exam.concat(bri.examcalenders.where(:category => "exam"))
      end


      puts '-'*80
      puts @exam.inspect
      puts '-'*80
    end
    respond_to do |format|
      format.js
      format.json { render json: {exam: @exam} }
    end
  end

  def quizdetail
    @grades = Grade.where('section IS NOT NULL').order('name')

  end

  def quizdata
     puts '-'*80
    if params[:grade_id].present? && params[:grade_id] != ""
      @exam = []
      Grade.find(params[:grade_id]).bridges.try(:each) do |bri|
        @exam.concat(bri.examcalenders.where(:category => "quiz"))
      end


      puts '-'*80
      puts @exam.inspect
      puts '-'*80
    end
    respond_to do |format|
      format.js
      format.json { render json: {exam: @exam} }
    end
  end

  # PATCH/PUT /examcalenders/1
  # PATCH/PUT /examcalenders/1.json
  def update
    respond_to do |format|
      if @examcalender.update(examcalender_params)
        format.html { redirect_to @examcalender, notice: 'Examcalender was successfully updated.' }
        format.json { render :show, status: :ok, location: @examcalender }
      else
        format.html { render :edit }
        format.json { render json: @examcalender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /examcalenders/1
  # DELETE /examcalenders/1.json
  def destroy
    @examcalender.destroy
    respond_to do |format|
      format.html { redirect_to examcalenders_url, notice: 'Examcalender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_examcalender
      @examcalender = Examcalender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def examcalender_params
      params.require(:examcalender).permit(:bridge_id, :title, :description, :category, :starttime, :endtime)
    end
end
