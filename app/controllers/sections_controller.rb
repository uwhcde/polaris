class SectionsController < ApplicationController
  before_filter :load_post
  before_filter :load_section, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]

  def new
    @section = @post.sections.build
  end

  def create
    sectionparams = section_params
    sectionparams[:user_id] = current_user.id

    @section = @post.sections.build(sectionparams)

    respond_to do |format|
      if @section.save
        format.html { redirect_to [@post, @section], notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_section
    @section = Section.find(params[:id])
  end

  def section_params
    section_params = params.require(:section).permit(:title, :description, :position, :user_id)
    section_params.update(params.permit(:post_id))
    section_params
  end
end
