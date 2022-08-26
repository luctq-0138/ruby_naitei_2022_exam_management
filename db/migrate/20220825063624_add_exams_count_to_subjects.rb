class AddExamsCountToSubjects < ActiveRecord::Migration[6.1]
  def self.up
    add_column :subjects, :exams_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :subjects, :exams_count
  end
end
