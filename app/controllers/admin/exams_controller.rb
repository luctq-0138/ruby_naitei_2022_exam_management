class Admin::ExamsController < Admin::BaseController
  before_action :find_user, only: %i(index show)
  before_action :find_exam, only: %i(show)

  def index
    @pagy, @list_exam = pagy Exam.newest.by_user(@user.id)
                                 .by_statuses([Exam.statuses[:failed],
                                              Exam.statuses[:passed]]),
                             items: Settings.pagy
  end

  def show
    @questions = @exam.questions
    @list_answer = @exam.answers
  end

  private

  def find_user
    @user = User.find_by id: params[:user_id]
    return if @user.present?

    flash[:danger] = t "not_found"
    redirect_to signup_path
  end

  def find_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam.present?

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
