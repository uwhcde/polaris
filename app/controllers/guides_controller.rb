class GuidesController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource :only => :vote

  before_action :set_guide, only: [:show, :edit, :update, :destroy, :vote]
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /guides
  # GET /guides.json
  def index
    @guides = Guide.all
  end

  # GET /guides/1
  # GET /guides/1.json
  def show
    @comments = @guide.root_comments
  end

  # GET /guides/new
  def new
    @guide = Guide.new
  end

  # GET /guides/1/edit
  def edit
  end

  # POST /guides
  # POST /guides.json
  def create

    guideparams = guide_params

    if params['guide']['picture_id'].present?
      attachment = Ckeditor::Picture.find(params['guide'][:picture_id])
      guideparams['picture'] = attachment
    end

    if params['guide']['tag_list'].present?
      tags = params['guide']['tag_list'].join(',')
      guideparams['tag_list'] = tags
    end

    @guide = Guide.new(guideparams)

    respond_to do |format|
      if @guide.save
        format.html { redirect_to @guide, notice: 'Guide was successfully created.' }
        format.json { render :show, status: :created, location: @guide }
      else
        format.html { render :new }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guides/1
  # PATCH/PUT /guides/1.json
  def update
    guideparams = guide_params

    if params['guide']['picture_id'].present?
      attachment = Ckeditor::Picture.find(params['guide'][:picture_id])
      guideparams['picture'] = attachment
    end

    if params['guide']['tag_list'].present?
      tags = params['guide']['tag_list'].join(',')
      guideparams['tag_list'] = tags
    end

    respond_to do |format|
      if @guide.update(guideparams)
        format.html { redirect_to @guide, notice: 'Guide was successfully updated.' }
        format.json { render :show, status: :ok, location: @guide }
      else
        format.html { render :edit }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guides/1
  # DELETE /guides/1.json
  def destroy
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to home_index_path, notice: 'Guide was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    value = params[:type] == "up" ? 'like' : 'bad'
    @guide.vote_by :voter => current_user, :vote => value

    respond_to do |format|
      format.json { render :vote, status: :ok, location: @guide }
      format.html { redirect_to :back, notice: "Thank you for voting" }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guide
      @guide = Guide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guide_params
      params.require(:guide).permit(:title, :short_description, :user_id, :picture_id, :tag_list, sections_attributes: [:id, :title, :description, :user_id, :_destroy])
    end
end
