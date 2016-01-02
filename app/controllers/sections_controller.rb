class SectionsController < ApplicationController
  before_filter :load_guide
  before_filter :load_section, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]

  def new
    @section = @guide.sections.build
  end

  def create
    sectionparams = section_params
    sectionparams[:user_id] = current_user.id

    @section = @guide.sections.build(sectionparams)

    respond_to do |format|
      if @section.save
        format.html { redirect_to [@guide, @section], notice: 'Guide was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @guide.update(guide_params)
        format.html { redirect_to @guide, notice: 'Guide was successfully updated.' }
        format.json { render :show, status: :ok, location: @guide }
      else
        format.html { render :edit }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end


  def show
  end

  private

  def load_guide
    @guide = Guide.find(params[:guide_id])
  end

  def load_section
    @section = Section.find(params[:id])
  end

  def section_params
    section_params = params.require(:section).permit(:title, :description, :position, :user_id)
    section_params.update(params.permit(:guide_id))
    section_params
  end
end
