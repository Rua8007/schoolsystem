class ShopcategoriesController < ApplicationController
  before_action :set_shopcategory, only: [:show, :edit, :update, :destroy]

  # GET /shopcategories
  # GET /shopcategories.json
  def index
    @shopcategories = Shopcategory.all
  end

  # GET /shopcategories/1
  # GET /shopcategories/1.json
  def show
  end

  # GET /shopcategories/new
  def new
    @shopcategory = Shopcategory.new
  end

  # GET /shopcategories/1/edit
  def edit
  end

  # POST /shopcategories
  # POST /shopcategories.json
  def create
    @shopcategory = Shopcategory.new(shopcategory_params)

    respond_to do |format|
      if @shopcategory.save
        format.html { redirect_to @shopcategory, notice: 'Shopcategory was successfully created.' }
        format.json { render :show, status: :created, location: @shopcategory }
      else
        format.html { render :new }
        format.json { render json: @shopcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shopcategories/1
  # PATCH/PUT /shopcategories/1.json
  def update
    respond_to do |format|
      if @shopcategory.update(shopcategory_params)
        format.html { redirect_to @shopcategory, notice: 'Shopcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @shopcategory }
      else
        format.html { render :edit }
        format.json { render json: @shopcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopcategories/1
  # DELETE /shopcategories/1.json
  def destroy
    @shopcategory.destroy
    respond_to do |format|
      format.html { redirect_to shopcategories_url, notice: 'Shopcategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopcategory
      @shopcategory = Shopcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopcategory_params
      params.require(:shopcategory).permit(:name)
    end
end
