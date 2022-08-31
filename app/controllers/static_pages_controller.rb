class StaticPagesController < ApplicationController
  before_action :time_out, only: %i(home)
  def home
    return unless user_signed_in?

    redirect_to admin_root_path if current_user.admin?

    @subject = Subject.pluck :name, :id
    @exam = Exam.new

    @search = Exam.ransack(params[:q])
    @pagy, @exam_item = pagy @search.result.newest.by_id(current_user.id),
                             items: Settings.pagy
  end

  private
  def time_out
    return unless user_signed_in?
    return unless current_user.exams

    exams = current_user.exams

    exams.each do |exam|
      exam.grade if exam.doing? && (exam.endtime <= Time.zone.now)
    end
  end
end
