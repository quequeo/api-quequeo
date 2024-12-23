class Api::V1::Me::ProjectsController < Api::ApplicationMeController
  before_action :set_project, only: %i[show update destroy]
  after_action :verify_authorized

  # GET /projects
  def index
    authorize Project
    @projects = current_user.projects.with_attached_logo
    render json: @projects, each_serializer: ProjectSerializer
  end

  # GET /projects/1
  def show
    authorize @project
    render json: @project
  end

  # POST /projects
  def create
    @project = current_user.projects.new(project_params)
    authorize @project

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    authorize @project
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    authorize @project
    if @project.destroy
      @project.logo.purge_later if @project.logo.attached?
      head :no_content
    else
      render json: { error: 'Failed to destroy project' }, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :logo)
  end
end
