class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :question_type
      t.string :question_content
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
    add_index :questions, [:subject_id, :created_at]
  end
end
