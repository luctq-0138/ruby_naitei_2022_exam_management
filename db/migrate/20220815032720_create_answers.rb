class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :is_correct, null: false, default: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
    add_index :answers, [:question_id, :created_at]
  end
end
