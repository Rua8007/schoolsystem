class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    if current_user.role.rights.where(value: "view_prequest").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    @purchases = Purchase.all
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    if current_user.role.rights.where(value: "create_prequest").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    @purchase = Purchase.new
    @grades = Grade.where('section IS NOT NULL').order('name')
    @teachers = Employee.order('full_name')
    @purchaselines = Purchaseline.all


  end


  def invoicing
    if current_user.role.rights.where(value: "create_prequest").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    inv = Purchase.create
    items = params[:items]
    inv.grade_id = params[:grade_id]
    inv.employee_id = params[:employee_id]
    inv.detail = params[:detail] 
    inv.save
    items.each do |item|

        temp = inv.purchaselines.create
        temp.code = item[1]['code']
        temp.quantity = item[1]['qty'].to_i
        temp.price = item[1]['price'].to_f
        temp.save

    end

    Notification.create(user_id: current_user.id, activity: "Created A New Purchase Request "  )

  redirect_to purchases_path
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json





  def approve
    if current_user.role.rights.where(value: "view_prequest").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    @purchase = Purchase.find(params[:id])
    @purchase.approve = true
    if @purchase.save
      redirect_to purchases_path, notice: "Purchase Request Approved Successfully"
    end
  end

  def disapprove
    if current_user.role.rights.where(value: "create_prequest").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    @purchase = Purchase.find(params[:id])
    @purchase.approve = false
    if @purchase.save
      redirect_to purchases_path, notice: "Purchase Request Approved Successfully"
    end
  end



  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:grade_id, :employee_id, :detail, :approve)
    end
end
