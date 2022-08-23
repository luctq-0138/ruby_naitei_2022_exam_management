class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.integer :exam_id
      t.integer :answer_id

      t.timestamps
    end
    add_index :records, :exam_id
    add_index :records, :answer_id
  end
end
