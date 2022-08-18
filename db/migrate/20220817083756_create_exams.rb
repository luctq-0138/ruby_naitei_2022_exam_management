class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.integer :status, default: 0
      t.integer :result, default: 0
      t.datetime :endtime
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true
      t.timestamps
    end
    add_index :exams, [:user_id, :created_at]
    add_index :exams, [:subject_id, :created_at]
  end
end
