class FeesController < ApplicationController
  before_action :set_fee, only: [:edit, :update, :destroy]

  # GET /fees
  # GET /fees.json
  def index
    if current_user.role.name == 'Parent'
      temp = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @fees = temp.fees.all
    else
      @fees = Fee.all
    end
    @fees = @fees.group_by { |p| p.identifier }
    # return render json: @fees.first.last
  end

  # GET /fees/1
  # GET /fees/1.json
  def show
    @fees = Fee.where(identifier: params[:id])
    @student = @fees.first.student
    @busfee = []
    if @student.bus_allotment.present?
      @busfee = @student.bus_allotment.transportfeerecords.where(identifier: params[:id])
    end
    # return render json: @fees
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
    # return render json: params
    # @fee = Fee.new(fee_params)
    # student = Student.find(params[:fee][:student_id])
    # temp = student.due_date.to_date
    # if student.term == 'Monthly'
    #   student.due_date = (temp + 1.month).to_s
    # elsif student.term == "Quarterly"
    #   student.due_date = (temp + 3.month).to_s
    # elsif student.term = "Bi-annualy"
    #   student.due_date = (temp + 6.month).to_s
    # end
    # student.save
    student = Student.find(params[:student_id])
    student.due_date = params[:due_date]
    student.save
    identifier = 1
    data = params[:flags]
    if Fee.all.any?
      if student.bus_allotment.present? && student.bus_allotment.transportfeerecords.any?
        if Fee.last.identifier >= student.bus_allotment.transportfeerecords.last.identifier
          identifier = Fee.last.identifier + 1
        else
          identifier = student.bus_allotment.transportfeerecords.last.identifier + 1
        end
      else
        identifier = Fee.last.identifier + 1
      end
    end
    data.each do |d|
      if d.last["id"] == 'bs'
        fee = student.fees.create
        fee.category = 'books'

        fee.amount = d.last["amount"].to_i
        fee.user_id = current_user.id
        fee.identifier = identifier
        fee.save
        puts "Bookshop Charges Paid"
      elsif d.last["id"] == 'ba'

        if student.bus_allotment.present?
          tfr = student.bus_allotment.transportfeerecords.create
          tfr.fee = d.last["amount"].to_i
          tfr.identifier = identifier
          tfr.save
        end
        puts "Transport Charges Paid"
      else
        fee = student.fees.create
        fee.category = ''

        fee.amount = d.last["amount"].to_i
        fee.user_id = current_user.id
        fee.feebreakdown_id = d.last["id"].to_i
        fee.identifier = identifier
        fee.save
        puts "Fee Charges Paid"

      end
    end
    redirect_to fee_path(identifier), notice: "Fee Submitted Successfully"
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

  def challan
    @student = Student.find(params[:student_id])
    grade = @student.grade
    @bcharges = 0
    if @student.invoices.any?
      @student.invoices.each do |i|
        @bcharges = @bcharges + i.lines.sum("quantity * price") - i.discount
      end
    end
    @fee_breakdown = grade.feebreakdowns
  end

  def student_fee
    @fee = Fee.new
    if Student.find_by_rollnumber(params[:id]).present?
      @student = Student.find_by_rollnumber(params[:id])
      @data = []
      @student.grade.feebreakdowns.each do |fb|
        fb.title = fb.title || ''
        temp = {id: fb.id, fb_id: fb.title, total:fb.amount, paid: fb.fees.sum(:amount) , pending: fb.amount-fb.fees.sum(:amount) }
        @data.push(temp)
      end
      if @student.bus_allotment.present?
        @data << { id: "ba", fb_id: "Transport Charges", total:@student.bus_allotment.fee , paid: @student.bus_allotment.transportfeerecords.sum(:fee) , pending: @student.bus_allotment.fee-@student.bus_allotment.transportfeerecords.sum(:fee) }
      end
      bcharges = 0
      @student.invoices.try(:each) do |inv|
        bcharges = bcharges + inv.lines.sum("quantity * price")
      end
      @data << {id: 'bs' ,fb_id: "Bookshop Charges", total:bcharges, paid: @student.fees.where(category: "books").sum(:amount), pending: bcharges-@student.fees.where(category: "books").sum(:amount) }

    else
      @student = nil
      @data = nil
    end
    respond_to do |format|
      format.js
      format.json {render json: {student: @student, data: @data}}
    end
  end

  def student_list
    @students = Student.all
    @student = @students.first
  end

  def buy_books
    @student = Student.find(params[:id])
    @books = @student.grade.items
    @packages = @student.grade.packages
  end

  def books_invoice
    student = Student.find(params[:student_id])
    inv = student.invoices.new
    inv.discount = 0
    inv.save
    books = params[:books]
    packages = params[:pkgs]
    books.try(:each) do |book|
      item = Item.find(book)
      item.left = item.left - 1
      item.sold = item.sold + 1
      item.save
      line = inv.lines.create
      line.item_id = item.id
      line.price = item.price
      line.quantity = 1
      line.save
    end

    packages.try(:each) do |pkg|
      package = Package.find(pkg)
      package.sold = package.sold + 1
      package.save

      package.items.try(:each) do |itm|
        itm.sold = itm.sold + 1
        itm.left = itm.left - 1
        itm.save
      end

      line = inv.lines.create
      line.package_id = pkg.id
      line.price = pkg.price
      line.quantity = 1
      line.save

    end

    redirect_to new_bus_allotment_path({skip: true}) , notice: "Purchasing is successful...!!!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:student_id, :amount, :user_id, :month, :category, :feebreakdown_id)
    end
end
