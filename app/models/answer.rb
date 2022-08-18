class Answer < ApplicationRecord
  belongs_to :question
  has_many :exam_relationships, class_name: Record.name,
                                dependent: :destroy
  has_many :exams, through: :exam_relationships, source: :exam
end
