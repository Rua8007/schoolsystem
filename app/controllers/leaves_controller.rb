class LeavesController < ApplicationController
  before_action :set_leave, only: [:show, :edit, :update, :destroy]

  # GET /leaves
  # GET /leaves.json
  def index
    @leaves = Leave.where(approved: false)
  end

  # GET /leaves/1
  # GET /leaves/1.json
  def show
  end

  # GET /leaves/new
  def new
    @leave = Leave.new
  end

  # GET /leaves/1/edit
  def edit
  end

  # POST /leaves
  # POST /leaves.json
  def create
    @leave = Leave.new(leave_params)

    respond_to do |format|
      if @leave.save
        format.html { redirect_to @leave, notice: 'Leave was successfully created.' }
        format.json { render :show, status: :created, location: @leave }
      else
        format.html { render :new }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaves/1
  # PATCH/PUT /leaves/1.json
  def update
    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to @leave, notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaves/1
  # DELETE /leaves/1.json
  def destroy
    ################################# Notify to employee ################
    @leave.destroy
    respond_to do |format|
      flash[:alert] = "Leave was disapproved."
      format.html { redirect_to leaves_path}
      format.json { head :no_content }
    end
  end

  def approve_leave
    # return render json: "Approval Code here for Leave: "+params[:id]
    leave = Leave.find(params[:id])
    if leave.present?
      leave.approved = true
      leave.save!
      ############################# Notify to employee #################
      if leave.employee.present?
        flash[:success] = "#{leave.try(:employee).try(:full_name)}'s leave approved."
      else
        flash[:success] = "Leave approved.'}"
      end
      redirect_to leaves_path
    else
      flash[:alert] = "Couldn't approve leave. Error."
      redirect_to leaves_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave
      @leave = Leave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_params
      params.require(:leave).permit(:reason, :description, :employee_id, :leave_from, :leave_to)
    end
end
