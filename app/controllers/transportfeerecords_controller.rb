class TransportfeerecordsController < ApplicationController
  before_action :set_transportfeerecord, only: [:show, :edit, :update, :destroy]

  # GET /transportfeerecords
  # GET /transportfeerecords.json
  def index
    if current_user.role == 'student'
      @transportfeerecords = Student.find_by_email(current_user.email).bus_allotment.transportfeerecords.all
    else
      @transportfeerecords = Transportfeerecord.all
    end
  end

  # GET /transportfeerecords/1
  # GET /transportfeerecords/1.json
  def show
  end

  # GET /transportfeerecords/new
  def new
    @transportfeerecord = Transportfeerecord.new
    @bus_allotment = BusAllotment.new
    @students=Student.all
    @route = Route.all
  end

  # GET /transportfeerecords/1/edit
  def edit
  end

  # POST /transportfeerecords
  # POST /transportfeerecords.json
  def create

    @transportfeerecord = Transportfeerecord.new
    @transportfeerecord.bus_allotment_id = params[:bus_allotment_id]

    respond_to do |format|
      if @transportfeerecord.save
        format.html { redirect_to @transportfeerecord, notice: 'Transportfeerecord was successfully created.' }
        format.json { render :show, status: :created, location: @transportfeerecord }
      else
        format.html { render :new }
        format.json { render json: @transportfeerecord.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /transportfeerecords/1
  # PATCH/PUT /transportfeerecords/1.json
  def update
    respond_to do |format|
      if @transportfeerecord.update(transportfeerecord_params)
        format.html { redirect_to @transportfeerecord, notice: 'Transportfeerecord was successfully updated.' }
        format.json { render :show, status: :ok, location: @transportfeerecord }
      else
        format.html { render :edit }
        format.json { render json: @transportfeerecord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportfeerecords/1
  # DELETE /transportfeerecords/1.json
  def destroy
    @transportfeerecord.destroy
    respond_to do |format|
      format.html { redirect_to transportfeerecords_url, notice: 'Transportfeerecord was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fee_data
    puts '-'*80
    if params[:student_id].present? && params[:student_id] != ""
      @routes = Student.find(params[:student_id]).bus_allotment
      puts '-'*80
      @routes.route.name
      puts '-'*80
    end
    respond_to do |format|
      format.js
      format.json { render json: {routes: @routes} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportfeerecord
      @transportfeerecord = Transportfeerecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transportfeerecord_params
      params.require(:transportfeerecord).permit(:bus_allotment_id, :fee)
    end
end
