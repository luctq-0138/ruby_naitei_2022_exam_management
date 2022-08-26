require "set"
module ExamsHelper
  def random_list time, max
    randoms = Set.new
    loop do
      randoms << rand(max)
      break if randoms.length == time
    end
    randoms.to_a
  end

  def is_checked? user_answers, current_answer, type
    input_type = type == Question.types[:single] ? "radio" : "checkbox"
    if user_answers.include? current_answer
      content_tag(:input, nil, type: input_type, disabled: true, checked: true)
    else
      content_tag(:input, nil, type: input_type, disabled: true)
    end
  end

  def result_of_question user_answers, current_question
    result = ""
    case current_question.question_type
    when Question.types[:single]
      correct_answer = current_question.answers.find_by is_correct: true
      result = user_answers.include?(correct_answer) ? "correct" : "wrong"
    when Question.types[:multiple]
      result = "correct"
      correct_answers = current_question.answers.get_answers(true)
      correct_answers.each do |answer|
        if user_answers.exclude? answer
          result = "wrong"
          break
        end
      end
    end

    show_result result
  end

  def show_result result
    text = result == "wrong" ? t("wrong_answer") : t("correct_answer")
    content_tag(:p, text, class: "result result-#{result}")
  end
end
