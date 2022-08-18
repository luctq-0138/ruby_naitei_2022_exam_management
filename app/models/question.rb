class Question < ApplicationRecord
  NESTED_ATTRS = %i(id content is_correct _destroy).freeze
  QUESTION_ATTRS = %i(question_content subject_id question_type)
                   .push(answers_attributes: NESTED_ATTRS)

  enum type: {single_choice: 0, multiple_choice: 1}

  belongs_to :subject

  has_many :answers, dependent: :destroy
  has_many :exam_relationships, class_name: Relationship.name,
                                dependent: :destroy
  has_many :exams, through: :exam_relationships, source: :exam
  accepts_nested_attributes_for :answers,
                                allow_destroy: true,
                                reject_if: proc{|att| att["content"].blank?}

  scope :get_by_type, ->(type){where question_type: type}

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
end
