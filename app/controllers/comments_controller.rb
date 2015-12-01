class CommentsController < ApplicationController

  def create
    @guide = Guide.find(params[:guide_id])
    @comment = @guide.comments.create!(params[:comment].permit!)
    redirect_to @guide
  end

end
