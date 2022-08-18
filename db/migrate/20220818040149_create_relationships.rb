class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :question_id
      t.integer :exam_id

      t.timestamps
    end
    add_index :relationships, :question_id
    add_index :relationships, :exam_id
  end
end
