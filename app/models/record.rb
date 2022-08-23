class Record < ApplicationRecord
  belongs_to :exam
  belongs_to :answer
  validates :exam_id, :answer_id, presence: true
end
