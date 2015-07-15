class BridgesController < ApplicationController
  before_action :set_bridge, only: [:show, :edit, :update, :destroy]

  # GET /bridges
  # GET /bridges.json
  def index
    @bridges = Bridge.all
  end

  # GET /bridges/1
  # GET /bridges/1.json
  def show
  end

  # GET /bridges/new
  def new
    @bridge = []
    Subject.all.try(:each) do |s|
      temp = {flag: false, subject_id: s.id, teacher_id: 1, class_id: params[:class_id] }
      @bridge << temp
    end
    # @bridge.each do |b|
    #   puts "-"*80
    #   # puts b["flag"]
    # end
  end

  # GET /bridges/1/edit
  def edit
  end

  # POST /bridges
  # POST /bridges.json
  def create
    @bridge = Bridge.new(bridge_params)

    respond_to do |format|
      if @bridge.save
        format.html { redirect_to @bridge, notice: 'Bridge was successfully created.' }
        format.json { render :show, status: :created, location: @bridge }
      else
        format.html { render :new }
        format.json { render json: @bridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bridges/1
  # PATCH/PUT /bridges/1.json
  def update
    respond_to do |format|
      if @bridge.update(bridge_params)
        format.html { redirect_to @bridge, notice: 'Bridge was successfully updated.' }
        format.json { render :show, status: :ok, location: @bridge }
      else
        format.html { render :edit }
        format.json { render json: @bridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bridges/1
  # DELETE /bridges/1.json
  def destroy
    @bridge.destroy
    respond_to do |format|
      format.html { redirect_to bridges_url, notice: 'Bridge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bridge
      @bridge = Bridge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bridge_params
      params.require(:bridge).permit(:subject_id, :grade_id, :employee_id)
    end
end
