class Subject < ApplicationRecord
  SUBJECT_ATTRS = %i(name description question_number duration
                                                      score_pass).freeze

  validates :name, :duration, :question_number, :score_pass, presence: true
  validates :description, length: {maximum: Settings.description_max_length}
  validates :duration, :question_number, :score_pass,
            numericality: {only_integer: true}
end
