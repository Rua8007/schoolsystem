class CreatePublishResult < ActiveRecord::Migration
  def change
    create_table :publish_results do |t|
      t.integer :class_id
      t.integer :batch_id
      t.boolean :publish
    end
  end
end
