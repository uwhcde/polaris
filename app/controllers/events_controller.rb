class EventsController < ApplicationController

  skip_authorize_resource :only => [:bookmark]

  before_action :set_event, only: [:show, :edit, :update, :destroy, :bookmark, :rsvp]

  impressionist :actions=>[:show], :unique => [:impressionable_type, :impressionable_id, :session_hash]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @comments = @event.root_comments
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create


    eventparams = event_params

    if params['event']['picture_id'].present?
      attachment = Ckeditor::Picture.find(params['event'][:picture_id])
      eventparams['picture'] = attachment
    end

    if params['event']['tag_list'].present?
      tags = params['event']['tag_list'].join(',')
      eventparams['tag_list'] = tags
    end

    @event = Event.new(eventparams)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to home_index_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def bookmark
    value = params[:type] == "yes" ? 1 : -1

    if value == 1
      @event.add_evaluation(:bookmark, 1, current_user)
    else
      @event.delete_evaluation!(:bookmark, current_user)
    end

    respond_to do |format|
      format.json { render :bookmark, status: :ok, location: @event }
      format.html { redirect_to :back, notice: "Thank you for voting" }
    end

  end

  def rsvp
    value = params[:type] == "yes" ? 1 : -1

    if value == 1
      @event.add_evaluation(:rsvp, 1, current_user)
    else
      @event.delete_evaluation!(:rsvp, current_user)
    end

    respond_to do |format|
      format.json { render :rsvp, status: :ok, location: @event }
      format.html { redirect_to :back, notice: "You are going to the event." }
    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :from, :to, :user_id, :picture_id, :tag_list, :location, :longitude, :latitude, :hostedby, :description, :intereted, :going, :invited, :cover)
    end
end
