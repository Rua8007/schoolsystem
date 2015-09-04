class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    if current_user.role != 'student'
      @invoices = Invoice.all
    else
      @invoices = Student.find_by_email(current_user.email).invoices
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @lines = @invoice.lines
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
    inv.discount = params[:discount]
    inv.save
    items.each do |item|
      itm = Item.find_by_code(item[1]['code'])
      if itm.nil?
        package = Package.find_by_code(item[1]['code'])
        puts "---"*80
        puts package.packageitems.inspect
        puts "---"*80
        package.packageitems.each do |it|
          p_item = it.item
          puts "---"*80
          puts it.inspect
          puts "---"*80
          p_item.sold = p_item.sold + item[1]['qty'].to_i
          p_item.left = p_item.left - item[1]['qty'].to_i
          p_item.save
          puts "---"*80
          puts it.inspect
          puts "---"*80
        end
        temp = inv.lines.create
        temp.package_id = package.id
        temp.quantity = item[1]['qty'].to_i
        temp.price = item[1]['price'].to_f
        temp.save
      else
        itm.sold = itm.sold + item[1]['qty'].to_i
        itm.left = itm.left - item[1]['qty'].to_i
        itm.save
        temp = inv.lines.create
        temp.item_id = itm.id
        temp.quantity = item[1]['qty'].to_i
        temp.price = item[1]['price'].to_f
        temp.save
      end
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
    redirect_to invoices_path
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

  def student_data
    if Student.find_by_id(params[:std_id]).present?
      student = Student.find(params[:std_id])
      @details = {fullname: student.fullname, parent: student.parent.name, contact: student.mobile, grade: student.grade.full_name}
    else
      @details = false
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
