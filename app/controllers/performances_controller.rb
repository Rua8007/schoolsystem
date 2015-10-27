class PerformancesController < ApplicationController
  before_action :set_performance, only: [:show, :edit, :update, :destroy]

  # GET /performances
  # GET /performances.json
  def index
    if current_user.role.name == 'Parent'
      temp = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last).id
      @performances = Performance.where(student_id: temp)
    elsif current_user.role.name == 'Student'
      temp = Student.find_by_email(current_user.email)
      @performances = Performance.where(student_id: temp)
    else
      @performances = Performance.all
    end
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
    # return render json: params
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

    if params[:fail].length == 2
      @performance.fail = true
    end

    if params[:les].length == 2
      @performance.les = true
    end



    if params[:good].length == 2
      @performance.good = true
    end

    if params[:st].length == 2
      @performance.st = true
    end

    if params[:vg].length == 2
      @performance.vg = true
    end

    if params[:exc].length == 2
      @performance.exc = true
    end

    if params[:tal].length == 2
      @performance.tal = true
    end

    if params[:sd].length == 2
      @performance.st = true
    end

    if params[:res].length == 2
      @performance.res = true
    end

    if params[:art].length == 2
      @performance.art = true
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
