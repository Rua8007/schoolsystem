class AddAttachmentColToLessonplanDetail < ActiveRecord::Migration
  def change
    add_column :lessonplan_details, :attachment, :string
  end
end
