class BusAllotmentsController < ApplicationController
  before_action :set_bus_allotment, only: [:show, :edit, :update, :destroy]

  # GET /bus_allotments
  # GET /bus_allotments.json
  def index
    if current_user.role == 'student'
      @bus_allotments = Student.find_by_email(current_user.email).bus_allotment
    else
      @bus_allotments = BusAllotment.all
    end

  end

  # GET /bus_allotments/1
  # GET /bus_allotments/1.json
  def show
  end

  # GET /bus_allotments/new
  def new
    @skip = false
    if(params[:skip])
      @skip = true
    end
    @bus_allotment = BusAllotment.new
    @students = Student.all
    @route = Route.try(:all).order(:name) || ''
    if @route.any?
      @stops = @route.first.stops
      @transports = @route.first.transports
    else
      @stops = []
      @transports = []
    end
  end

  # GET /bus_allotments/1/edit
  def edit
    @students=Student.all
    @transports = @route.first.transports

    @route = Route.all.order(:name)
    @stops = @route.first.stops
  end

  # POST /bus_allotments
  # POST /bus_allotments.json
  def create
    @bus_allotment = BusAllotment.new(bus_allotment_params)
    @bus_allotment.student_id = Student.find_by_rollnumber(@bus_allotment.student_id.to_s).id
    respond_to do |format|
      if @bus_allotment.save
        Notification.create(user_id: current_user.id, activity: "Created made a bus allotment to #{@bus_allotment.student.full_name} "  )
        format.html { redirect_to bus_allotments_path, notice: 'Bus allotment was successfully created.' }
        format.json { render :show, status: :created, location: @bus_allotment }
      else
        format.html { render :new }
        format.json { render json: @bus_allotment.errors, status: :unprocessable_entity }
      end
    end
  end

  def stops_data
    puts '-'*80
    if params[:route_id].present? && params[:route_id] != ""
      @stops = Route.find(params[:route_id]).stops
      @transports = Route.find(params[:route_id]).transports
    end
    respond_to do |format|
      format.js
      format.json { render json: {stops: @stops,transports: @transports} }
    end
  end



  # PATCH/PUT /bus_allotments/1
  # PATCH/PUT /bus_allotments/1.json
  def update
    respond_to do |format|
      if @bus_allotment.update(bus_allotment_params)
        format.html { redirect_to @bus_allotment, notice: 'Bus allotment was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus_allotment }
      else
        format.html { render :edit }
        format.json { render json: @bus_allotment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bus_allotments/1
  # DELETE /bus_allotments/1.json
  def destroy
    @bus_allotment.destroy
    respond_to do |format|
      format.html { redirect_to bus_allotments_url, notice: 'Bus allotment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bus_allotment
      @bus_allotment = BusAllotment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bus_allotment_params
      params.require(:bus_allotment).permit(:fee, :student_id, :transport_id, :route_id, :stop_id)
    end
end
