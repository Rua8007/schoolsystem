class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @items = Item.all
    @lines =Line.all
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def invoicing
    inv = Invoice.create
    items = params[:items]
    inv.student_id = params[:student_id]
    inv.booknum = params[:booknum]
    inv.save
    items.each do |item|
      puts "----"*80
      puts item[1]['code']
      puts "----"*80
      itm = Item.find_by_code(item[1]['code'])
      itm.sold = itm.sold + item[2].to_i
      itm.left = itm.left - item[2].to_i
      itm.save
      temp = inv.lines.create
      temp.item_id = itm.id
      temp.quantity = item[2].to_i
      temp.save
    end
    # return render json: params
    # @invoice = Invoice.new(invoice_params)

    # respond_to do |format|
    #   if @invoice.save
    #     format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
    #     format.json { render :show, status: :created, location: @invoice }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @invoice.errors, status: :unprocessable_entity }
    #   end
    # end
    redirect_to grades_path 
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def items_data
    @details = Item.find_by_code(params[:item_id])   
    if @details.blank?
      @details = Package.find_by_code(params[:item_id])
    end

    respond_to do |format|
      format.json {render json: [details: @details]}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:booknum, :student_id, :discount)
    end
end
