class StaticPagesController < ApplicationController
  before_action :time_out, only: %i(home)
  def home
    return unless logged_in?

    @subject = Subject.pluck :name, :id
    @exam = Exam.new
    @pagy, @exam_item = pagy Exam.newest.by_user(current_user.id),
                             items: Settings.pagy
  end

  private
  def time_out
    return unless logged_in?
    return unless current_user.exams

    exams = current_user.exams

    exams.each do |exam|
      exam.grade if exam.doing? && (exam.endtime <= Time.zone.now)
    end
  end
end
