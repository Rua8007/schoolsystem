class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy]

  # GET /batches
  # GET /batches.json
  def index
    if current_user.role.rights.where(value: 'batch').any?
      @batches = Batch.all
    else
      redirect_to root_path, alert: "Not Authorized...!!!"
    end
  end

  # GET /batches/1
  # GET /batches/1.json
  def show
  end

  # GET /batches/new
  def new
    if current_user.role.rights.where(value: 'batch').any?
    else
      redirect_to root_path, alert: "Not Authorized...!!!"
    end
    @batch = Batch.new
  end

  # GET /batches/1/edit
  def edit
    if current_user.role.rights.where(value: 'batch').any?
    else
      redirect_to root_path, alert: "Not Authorized...!!!"
    end
  end

  # POST /batches
  # POST /batches.json
  def create
    if current_user.role.rights.where(value: 'batch').any?
      @batch = Batch.new(batch_params)
    else
      redirect_to root_path, alert: "Not Authorized...!!!"
    end

    respond_to do |format|
      if @batch.save
        format.html { redirect_to batches_path, notice: 'Batch was successfully created.' }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1
  # PATCH/PUT /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to @batch, notice: 'Batch was successfully updated.' }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.json
  def destroy
    # @batch.destroy
    respond_to do |format|
      format.html { redirect_to batches_url, notice: 'Batch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batch_params
      params.require(:batch).permit(:name)
    end
end
