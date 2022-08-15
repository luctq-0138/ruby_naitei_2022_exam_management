class StaticPagesController < ApplicationController
  def home
    @subject = Subject.pluck :name, :id
  end
end
