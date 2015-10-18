class PerformancesController < ApplicationController
  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  # GET /performances
  # GET /performances.json
  def index
    @performances = Performance.all

  end

  # GET /performances/1
  # GET /performances/1.json
  def show
  end

  # GET /performances/new
  def new
    @performance = Performance.new
    @student_id = params[:student_id]
    @bridge_id = params[:bridge_id]
    @bridges = Bridge.all
  end

  # GET /performances/1/edit
  def edit
    @students = Student.all
    @bridges = Bridge.all

  end

  # POST /performances
  # POST /performances.json
  def create
    @performance = Performance.new(performance_params)
    if params[:lc].length == 2
      @performance.lc = true
    end

    if params[:fa].length == 2
      @performance.fa = true
    end

    if params[:pc].length == 2
      @performance.pc = true
    end

    if params[:pw].length == 2
      @performance.pw = true
    end

    if params[:lk].length == 2
      @performance.lk = true
    end

    if params[:ia].length == 2
      @performance.ia = true
    end

    respond_to do |format|
      if @performance.save
        format.html { redirect_to @performance, notice: 'Performance was successfully created.' }
        format.json { render :show, status: :created, location: @performance }
      else
        format.html { render :new }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performances/1
  # PATCH/PUT /performances/1.json
  def update
    respond_to do |format|
      if @performance.update(performance_params)
        format.html { redirect_to @performance, notice: 'Performance was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance }
      else
        format.html { render :edit }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performances/1
  # DELETE /performances/1.json
  def destroy
    @performance.destroy
    respond_to do |format|
      format.html { redirect_to performances_url, notice: 'Performance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance
      @performance = Performance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performance_params
      params.require(:performance).permit(:student_id, :bridge_id, :remark)
    end
end
