class Subject < ApplicationRecord
  validates :name, :duration, :question_number, :score_pass, presence: true
  validates :description, length: {maximum: Settings.max_length}
  validates :duration, :question_number, :score_pass,
            numericality: {only_integer: true}
end
