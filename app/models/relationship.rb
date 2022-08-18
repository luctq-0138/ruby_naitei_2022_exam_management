class Relationship < ApplicationRecord
  belongs_to :exam
  belongs_to :question
  validates :exam_id, :question_id, presence: true
end
