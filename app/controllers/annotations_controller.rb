class AnnotationsController < ApplicationController
  def create
    @annotation = current_user.annotations.create!(params[:annotation].permit(:event_id, :notes))
    respond_to do |wants|
      wants.html { redirect_to :back, notice: "Annotation created" }
      wants.js   { render text: annotation_path(@annotation), status: :created }
    end
  end

  def update
    @annotation = current_user.annotations.find(params[:id])
    @annotation.update_attributes!(params[:annotation].permit(:event_id, :notes))
    respond_to do |wants|
      wants.html { redirect_to :back, notice: "Annotation updated" }
      wants.js   { head :ok }
    end
  end
end
