class Admin::QuestionsController < Admin::BaseController
  def index; end

  def new
    @question = Question.new
    @subject = Subject.pluck :name, :id
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = t ".created"
      redirect_to admin_root_path
    else
      flash[:error] = t ".create_failed"
      render :new
    end
  end

  def edit; end

  private
  def question_params
    params.require(:question).permit :question_content,
                                     :subject_id, :question_type,
                                     answers_attributes: [:content, :is_correct]
  end
end
