class FeesController < ApplicationController
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  # GET /fees
  # GET /fees.json
  def index
    if current_user.role == 'student'
      @fees = Student.find_by_email(current_user.email).fees.all
    else
      @fees = Fee.all
    end
  end

  # GET /fees/1
  # GET /fees/1.json
  def show
  end

  # GET /fees/new
  def new
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
  end

  # POST /fees
  # POST /fees.json
  def create
    @fee = Fee.new(fee_params)
    student = Student.find(params[:fee][:student_id])
    temp = student.due_date.to_date
    if student.term == 'Monthly'
      student.due_date = (temp + 1.month).to_s
    elsif student.term == "Quarterly"
      student.due_date = (temp + 3.month).to_s
    elsif student.term = "Bi-annualy"
      student.due_date = (temp + 6.month).to_s
    end
    student.save
    @fee.save
    redirect_to fee_path(@fee.id), notice: "Fee Submitted Successfully"
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to @fee, notice: 'Fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to fees_url, notice: 'Fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fee_defaulter
    @students = Student.where("date(due_date)<= ?", Date.today)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:student_id, :amount, :user_id, :month)
    end
end
