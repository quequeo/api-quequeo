class Api::V1::Me::ProjectsController < ApplicationController
  before_action :set_user, only: %i[ index create show update destroy ]
  before_action :set_project, only: %i[ show update destroy ]

  # GET /projects
  def index
    @projects = @user.projects.with_attached_logo.with_attached_images

    projects_with_attachments = @projects.map(&:build_json)
  
    render json: projects_with_attachments
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = @user.projects.new(project_params)
    if params[:project][:logo].present?
      @project.logo.attach(params[:project][:logo])
    end
    if params[:project][:images].present?
      @project.images.attach(params[:project][:images])
    end
  
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      if params[:project][:logo].present?
        @project.logo.attach(params[:project][:logo])
      end
      if params[:project][:images].present?
        @project.images.attach(params[:project][:images])
      end
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy!
  end

  private

  def set_user
    @user = User.find_by(email: 'admin@quequeo.com')
  end

  def set_project
    @project = @user.projects.find(params.expect(:id))
  end


  def project_params
    params.require(:project).permit(:title, :description, :logo, images: [])
  end
end
