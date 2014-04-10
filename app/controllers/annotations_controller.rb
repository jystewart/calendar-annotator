class AnnotationsController < ApplicationController
  def create
    @annotation = current_user.annotations.create!(params[:annotation].permit(:event_id, :notes))
    redirect_to :back, notice: "Annotation created"
  end

  def update
    @annotation = current_user.annotations.find(params[:id])
    @annotation.update_attributes!(params[:annotation].permit(:event_id, :notes))
    redirect_to :back, notice: "Annotation created"
  end
end
