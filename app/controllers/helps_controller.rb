class HelpsController < ApplicationController

  skip_authorize_resource :only => [:bookmark]
  before_action :set_help, only: [:show, :edit, :update, :destroy, :bookmark]
  impressionist :actions=>[:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]
  load_and_authorize_resource

  # GET /helps
  # GET /helps.json
  def index
    @helps = Help.all
  end

  # GET /helps/1
  # GET /helps/1.json
  def show
    @comments = @help.root_comments
  end

  # GET /helps/new
  def new
    @help = Help.new
  end

  # GET /helps/1/edit
  def edit
  end

  # POST /helps
  # POST /helps.json
  def create

    helpparams = help_params

    if params['help']['picture_id'].present?
      attachment = Ckeditor::Picture.find(params['help'][:picture_id])
      helpparams['picture'] = attachment
    end

    if params['help']['tag_list'].present?
      tags = params['help']['tag_list'].join(',')
      helpparams['tag_list'] = tags
    end

    @help = Help.new(helpparams)

    respond_to do |format|
      if @help.save
        format.html { redirect_to @help, notice: 'Help was successfully created.' }
        format.json { render :show, status: :created, location: @help }
      else
        format.html { render :new }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /helps/1
  # PATCH/PUT /helps/1.json
  def update
    respond_to do |format|
      if @help.update(help_params)
        format.html { redirect_to @help, notice: 'Help was successfully updated.' }
        format.json { render :show, status: :ok, location: @help }
      else
        format.html { render :edit }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /helps/1
  # DELETE /helps/1.json
  def destroy
    @help.destroy
    respond_to do |format|
      format.html { redirect_to home_index_path, notice: 'Help was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def bookmark
    value = params[:type] == "yes" ? 1 : -1

    if value == 1
      @help.add_evaluation(:bookmark, 1, current_user)
    else
      @help.delete_evaluation!(:bookmark, current_user)
    end

    respond_to do |format|
      format.json { render :bookmark, status: :ok, location: @help }
      format.html { redirect_to :back, notice: "Thank you for voting" }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help
      @help = Help.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_params
      params.require(:help).permit(:title, :user_id, :location, :longitude, :latitude, :requiredby, :description, :picture_id, :date)
    end
end
