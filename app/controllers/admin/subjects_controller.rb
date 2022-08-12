class Admin::SubjectsController < Admin::BaseController
  def index
    @pagy, @subject_item = pagy Subject.all, items: Settings.pagy
  end

  def new
    @subject = Subject.new
    return if @subject

    flash.now[:error] = t "not_found"
    redirect_to root_path
  end
end
