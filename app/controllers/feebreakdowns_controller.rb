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
    @grades = Grade.where(section: nil).order(:name).pluck(:name, :id)
  end

  # GET /feebreakdowns/1/edit
  def edit
    @grades = Grade.where(section: nil).order(:name).pluck(:name, :id)

  end

  # POST /feebreakdowns
  # POST /feebreakdowns.json
  def create
    # return render json: params
    titles = params[:titles]
    amounts = params[:amounts]
    terms = params[:terms]
    titles.zip(amounts, terms).each do |title, amount, term|
      if title != '' || amount != '' || terms != ''
        puts
        puts
        puts
        puts term
        puts
        puts
        feebreakdown = Feebreakdown.new
        feebreakdown.grade_id = params[:grade]
        feebreakdown.title = title
        feebreakdown.amount = amount
        feebreakdown.term = term
        feebreakdown.save
        feentry = FeeEntry.new
        feentry.total_amount = amount
        feentry.name = title
        feentry.grade_id = params[:grade]
        feentry.save

      end
    end
    respond_to do |format|
      format.html { redirect_to feebreakdowns_path, notice: 'Feebreakdowns were successfully created.' }
      format.json { render :show, status: :created, location: @feebreakdown }
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
      params.require(:feebreakdown).permit(:grade_id, :title, :amount, :term)
    end
end
