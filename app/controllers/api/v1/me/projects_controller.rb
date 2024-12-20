class Api::V1::Me::ProjectsController < ApplicationController
  before_action :set_user, only: %i[ index create show update destroy ]
  before_action :set_project, only: %i[ show update destroy ]

  # GET /projects
  def index
    if @user.nil?
      render json: { errors: [ "No user found" ] }, status: :not_found
      return
    end
  
    if @user.projects.empty?
      render json: { errors: [ "No projects found" ] }, status: :not_found
      return
    end
  
    @projects = @user.projects.with_attached_logo
    render json: @projects, each_serializer: ProjectSerializer
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = @user.projects.new(project_params)
  
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    if @project.destroy
      @project.logo.purge_later if @project.logo.attached?

      head :no_content
    else
      render json: { error: 'Failed to destroy project' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user ||= User.find_by(email: 'admin@quequeo.com')
  end

  def set_project
    @project = @user.projects.find params[:id]
  end


  def project_params
    params.require(:project).permit(:title, :description, :logo)
  end
end
