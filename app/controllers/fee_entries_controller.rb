class FeeEntriesController < ApplicationController
  before_action :set_fee_entry, only: [:show, :edit, :update, :destroy]

  # GET /fee_entries
  # GET /fee_entries.json
  def index
    @fee_entries = FeeEntry.all
  end

  # GET /fee_entries/1
  # GET /fee_entries/1.json
  def show
  end

  # GET /fee_entries/new
  def new
    @fee_entry = FeeEntry.new
    @grades = Grade.where(section: nil).order('name')
  end

  # GET /fee_entries/1/edit
  def edit
    @grades = Grade.where(section: nil).order('name')
  end

  # POST /fee_entries
  # POST /fee_entries.json
  def create
    grade_ids = params[:fee_entry][:grade_id]
    grade_ids = grade_ids.compact
    if grade_ids.present?
      grade_ids.each do |grade_id|
        fee_entry = FeeEntry.new(fee_entry_params)
        fee_entry.grade_id = grade_id
        @success = fee_entry.save
      end
    else
      @success = false
    end

    respond_to do |format|
      if @success
        format.html { redirect_to fee_entries_path, notice: 'Fee entry was successfully created for grades selected.' }
        format.json { render :show, status: :created, location: @fee_entry }
      else
        format.html { render :new }
        format.json { render json: @fee_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fee_entries/1
  # PATCH/PUT /fee_entries/1.json
  def update
    respond_to do |format|
      if @fee_entry.update(fee_entry_params)
        format.html { redirect_to @fee_entry, notice: 'Fee entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee_entry }
      else
        format.html { render :edit }
        format.json { render json: @fee_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fee_entries/1
  # DELETE /fee_entries/1.json
  def destroy
    @fee_entry.destroy
    respond_to do |format|
      format.html { redirect_to fee_entries_url, notice: 'Fee entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee_entry
      @fee_entry = FeeEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_entry_params
      params.require(:fee_entry).permit(:name, :total_amount, :mandatory, :grade_id)
    end
end
