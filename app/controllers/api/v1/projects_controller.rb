class Api::V1::ProjectsController < ApplicationController
  before_action :set_user, only: %i[ index create show update destroy ]
  before_action :set_project, only: %i[ show update destroy ]

  # GET /projects
  def index
    @projects = @user.projects

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = @user.projects.create(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
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
    @project.destroy!
  end

  private

    def set_user
      @user = User.find(:user_id)
    end

    def set_project
      @project = @user.projects.find(params.expect(:id))
    end


    def project_params
      params.expect(project: [ :title, :description, :url ])
    end
end
