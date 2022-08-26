class Question < ApplicationRecord
  NESTED_ATTRS = %i(id content is_correct _destroy).freeze
  QUESTION_ATTRS = %i(question_content subject_id question_type)
                   .push(answers_attributes: NESTED_ATTRS)
  MIN_ANSWER = 2

  enum type: {single: 0, multiple: 1}

  belongs_to :subject
  counter_culture :subject

  has_many :answers, dependent: :destroy
  has_many :exam_relationships, class_name: Relationship.name,
                                dependent: :destroy
  has_many :exams, through: :exam_relationships, source: :exam
  accepts_nested_attributes_for :answers,
                                allow_destroy: true,
                                reject_if: proc{|att| att["content"].blank?}

  validates :question_content, :subject_id, :question_type, presence: true
  validates :question_type, inclusion: {in: Question.types.values}
  validate :check_single_choice, on: %i(create update)

  scope :get_by_type, ->(type){where question_type: type}
  scope :by_subject, ->(id){where subject_id: id if id.present?}

  class << self
    def types_i18n
      types.map do |key, value|
        [I18n.t("question.type.#{key}"), value]
      end
    end
  end

  def type_i18n type_id
    type = Question.types.keys[type_id]
    I18n.t("question.type.#{type}")
  end

  private
  def check_valid_question
    return true if answers.size >= MIN_ANSWER

    errors.add(:question_content, :not_enough_answer)
  end

  def check_single_choice
    check_valid_question
    correct_count = answers.map(&:is_correct).count(true)
    return true if correct_count.positive? &&
                   question_type == Question.types[:multiple]
    return true if correct_count == Settings.single_correct_answer &&
                   question_type == Question.types[:single]

    errors.add(:answers, :not_valid_correct_answer_number)
  end
end
