class FeebreakdownsController < ApplicationController
  before_action :set_feebreakdown, only: [:show, :edit, :update, :destroy]

  # GET /feebreakdowns
  # GET /feebreakdowns.json
  def index
    @feebreakdowns = Feebreakdown.all
  end

  # GET /feebreakdowns/1
  # GET /feebreakdowns/1.json
  def show
  end

  # GET /feebreakdowns/new
  def new
    @feebreakdown = Feebreakdown.new
  end

  # GET /feebreakdowns/1/edit
  def edit
  end

  # POST /feebreakdowns
  # POST /feebreakdowns.json
  def create
    @feebreakdown = Feebreakdown.new(feebreakdown_params)

    respond_to do |format|
      if @feebreakdown.save
        format.html { redirect_to @feebreakdown, notice: 'Feebreakdown was successfully created.' }
        format.json { render :show, status: :created, location: @feebreakdown }
      else
        format.html { render :new }
        format.json { render json: @feebreakdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feebreakdowns/1
  # PATCH/PUT /feebreakdowns/1.json
  def update
    respond_to do |format|
      if @feebreakdown.update(feebreakdown_params)
        format.html { redirect_to @feebreakdown, notice: 'Feebreakdown was successfully updated.' }
        format.json { render :show, status: :ok, location: @feebreakdown }
      else
        format.html { render :edit }
        format.json { render json: @feebreakdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feebreakdowns/1
  # DELETE /feebreakdowns/1.json
  def destroy
    @feebreakdown.destroy
    respond_to do |format|
      format.html { redirect_to feebreakdowns_url, notice: 'Feebreakdown was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feebreakdown
      @feebreakdown = Feebreakdown.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feebreakdown_params
      params.require(:feebreakdown).permit(:grade_id, :title, :amount)
    end
end
