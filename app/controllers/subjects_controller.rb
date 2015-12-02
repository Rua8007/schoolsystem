class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.where(parent: nil).order(:name)
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    if current_user.role.rights.where(value: "create_subject").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    if current_user.role.rights.where(value: "update_subject").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_path, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    if current_user.role.rights.where(value: "delete_subject").nil?
      redirect_to :back, "Sorry! You are not authorized"
    end
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def group_subjects
    @grades = Grade.where(section: nil).order('name')
    @grade = params[:grade_id].present? ? Grade.find(params[:grade_id]) : @grades.first
    @bridges = Association.where(grade_id: @grade.id)
    @subjects = []
    if @bridges.present?
      @bridges.each do |bridge|
        @subjects << bridge.subject if bridge.subject.try(:parent).nil?
      end
    end

    @subject = Subject.new
    @subjects = @subjects.sort_by{ |k| k.name }
  end

  def save_subjects_groups
    @grade = Grade.find(params[:grade_id])
    @setting = ReportCardSetting.find_by(grade_id: @grade.id, batch_id: Batch.last.try(:id) )

    @subjects = params[:subjects] || []
    @subjects.each do |subject_id|
      parent = Subject.find(subject_id)
      report_card_parent = @setting.subjects.find_or_create_by(name: parent.name, code: parent.code)
      report_card_children = ReportCardSubject.where(parent_id: report_card_parent.id)
      report_card_children.try(:each) do |report_card_subject|
        report_card_subject.update(parent_id: nil)
      end
      children = params[:children]["#{subject_id}"]
      weights = params[:weight]["#{subject_id}"]
      parent.sub_subjects.each do |sub_subject|
        sub_subject.update(parent_id: nil)
      end
      if children.present?
        children.each_with_index do |child_id, index|
          child = Subject.find(child_id)
          weights = weights.reject { |w| w.to_s.empty? }
          weight = weights[index] if weights.present?
          report_card_child = @setting.subjects.find_or_create_by(name: child.name, code: child.code)
          child.update(parent_id: parent.id, weight: (weight || 0.00) )
          puts "#{child.name} : #{report_card_child.inspect}"
          puts '========================================'
          report_card_child.update(parent_id: report_card_parent.id, weight: (weight || 0.00) )
        end
      end
    end

    redirect_to group_subjects_path, grade_id: @grade.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name, :code, :parent_id,
                                      sub_subjects_attributes: [:id, :name, :code, :parent_id, :weight, :_destroy]
      )
    end
end
