class Admin::StaticPagesController < Admin::BaseController
  def index
    @pagy, @subject_item = pagy Subject.all, items: Settings.pagy
  end
end
