class Question < ApplicationRecord
  enum type: {single_choice: 0, text_question: 1}
  belongs_to :subject
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers,
                                allow_destroy: true,
                                reject_if: proc{|att| att["content"].blank?}

  class << self
    def types_i18n
      types.keys.map do |key|
        [I18n.t("question.type.#{key}"), key]
      end
    end
  end

  def type_i18n
    I18n.t("question.type.#{type}")
  end
end
