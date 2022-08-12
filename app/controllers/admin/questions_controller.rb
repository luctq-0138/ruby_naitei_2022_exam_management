class Admin::QuestionsController < Admin::BaseController
  before_action :find_question, except: %i(index new create)

  def index
    @pagy, @question_item = pagy Question.all, items: Settings.pagy
  end

  def new
    @question = Question.new
    @subject = Subject.pluck :name, :id
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = t ".created"
      redirect_to admin_questions_path
    else
      flash[:error] = t ".create_failed"
      render :new
    end
  end

  def edit
    @subject = Subject.pluck :name, :id
    @type = Question.types
  end

  def update
    @answer_item = Question.find_by id: params[:id]
    if @question.update question_params
      flash[:success] = "update_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = "update_false"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = "Question deleted"
    else
      flash[:danger] =  "Questiom delete failed"
    end
    redirect_to admin_questions_path
  end

  private
  def question_params
    params.require(:question).permit Question::QUESTION_ATTRS
  end

  def find_question
    @question = Question.find_by id: params[:id]
    return if @question.present?

    flash[:danger] = t "not_found"
    redirect_to admin_questions_path
  end
end
