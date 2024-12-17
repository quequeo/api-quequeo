class Api::V1::Me::ProjectsController < ApplicationController
  before_action :set_user, only: %i[ index create show update destroy ]
  before_action :set_project, only: %i[ show update destroy ]

  def index
    @projects = @user.projects.with_attached_logo

    projects_with_attachments = @projects.map(&:build_json)
  
    render json: projects_with_attachments
  end

  def show
    render json: @project
  end

  def create
    @project = @user.projects.new(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end
  
  def project_params
    params.require(:project).permit(:title, :description, :logo)
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

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
