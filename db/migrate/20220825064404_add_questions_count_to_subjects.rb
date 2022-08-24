class AddQuestionsCountToSubjects < ActiveRecord::Migration[6.1]
  def self.up
    add_column :subjects, :questions_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :subjects, :questions_count
  end
end
