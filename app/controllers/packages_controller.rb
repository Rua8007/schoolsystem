class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
    @grades = Grade.all
    @items =Item.all
     @employee=Employee.all.pluck(:full_name,:id)
    @packageitem = []
    Item.all.try(:each) do |i|
      temp = {flag: false, package_id: @package, item_id: i.id }
      @packageitem << temp
    end
  end

  # GET /packages/1/edit
  def edit
    @grades = Grade.all
    @items =Item.all
     @employee=Employee.all.pluck(:full_name,:id)
    @packageitem = []
    Item.all.try(:each) do |i|
      temp = {flag: false, package_id: @package, item_id: i.id }
      @packageitem << temp
    end
   
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    items = params[:items]

    respond_to do |format|
      if @package.save
        items.each do |it|
          packageitem = @package.packageitems.new
          packageitem.item_id = it.first
          packageitem.save
        end

        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end  
    end
  end


  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def items_data
    puts '-'*80
    if params[:grade_id].present? && params[:grade_id] != ""
      @items = Grade.find(params[:grade_id]).items


      puts '-'*80
      puts @stops
      puts '-'*80
    end
    respond_to do |format|
      format.js
      format.json { render json: {items: @items} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :code, :price, :sold, :grade_id)
    end
end
