class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]

  # GET /parents
  # GET /parents.json
  def index
    @parents = Parent.all

  end

  # GET /parents/1
  # GET /parents/1.json
  def show

  end

  # GET /parents/new
  def new
    @s = params[:student_id]
    @student = Student.find(params[:student_id])
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  def edit_parent
    @parent = Parent.find(params[:id])
    @student = @parent.students.first
    @edit = true

  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(parent_params)
    student = Student.find(params[:student_id])

    if @parent.save
      student.parent_id = @parent.id
      student.save
      redirect_to student_path(student.id)
      # format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
      # format.json { render :show, status: :created, location: @parent }
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update

    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to root_path, notice: 'Parent Detail Saved.' }
      else
        format.html { render :edit }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  def destroy
    @parent.destroy
    respond_to do |format|
      format.html { redirect_to parents_url, notice: 'Parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def parents_data
    puts "-"*80
    puts params
    puts "-"*80
    if params[:parent_id] == "new"
      @parent = Parent.new
      @flag = true
    elsif Student.find_by_rollnumber(params[:rollnumber]).present?
      @parent = Student.find_by_rollnumber(params[:rollnumber]).parent
      @flag = false
    else
      @parent = {}
    end
    @student = Student.find(params[:student_id])
    respond_to do |format|
      format.js
      format.json { render json: {parent: @parent} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.require(:parent).permit( :name, :relation, :education, :profession, :dob, :income, :iqamaNumber, :iqamaExpiry, :address1, :address2, :city, :country, :officePhone, :mobile,:mothername,:mothermobile,:motheremail, :email,emergencies_attributes: [:name,:phone, :mobile, :email, :student_id])
    end


end
