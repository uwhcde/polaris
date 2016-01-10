class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :vote]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = comment.new
  end

  # GET /comments/1/edit
  def edit
  end


  def vote
    value = params[:type] == "up" ? 'like' : 'bad'
    @comment.vote_by :voter => current_user, :vote => value

    respond_to do |format|
      format.html { redirect_to :back, notice: "Thank you for voting" }
      format.json { render :vote, status: :ok, location: @guide }
      # format.json { render :show, status: :ok, votesups: @guide.get_upvotes.size}
    end

  end


  # POST /comments
  # POST /comments.json
  def create

    if comment_params[:post_type] == 'Guide'
      @post = Guide.find(comment_params[:post_id])
    end
    if comment_params[:post_type] == 'Help'
      @post = Help.find(comment_params[:post_id])
    end
    if comment_params[:post_type] == 'Event'
      @post = Event.find(comment_params[:post_id])
    end

    @comment = Comment.build_from( @post, current_user.id, comment_params[:body])

    is_saved = @comment.save

    if comment_params[:parent_id]
      p "Comss here.. in parents... "
      @parent_comment = Comment.find(comment_params[:parent_id])
      @comment.move_to_child_of(@parent_comment)
    end

    respond_to do |format|
      if is_saved
        p "Comss here.. "
        format.html { redirect_to @post, notice: 'comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render json: @comment.errors, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :user_id, :body, :parent_id, :post_type)
    end
end
