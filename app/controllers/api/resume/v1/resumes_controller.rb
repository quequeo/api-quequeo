
class Api::Resume::V1::ResumesController < Api::Resume::ApplicationController
  after_action :verify_authorized, except: %i[index create]
  before_action :authorize_resume, only: %i[show update destroy]

  # GET /api/resume/v1/resumes
  def index
    resumes = current_user.resumes.includes(:sections)
    render json: resumes, include: :sections, status: :ok
  end

  # POST /api/resume/v1/resumes
  def create
    new_resume = current_user.resumes.new(resume_params)
    authorize new_resume

    if new_resume.save
      render json: new_resume, status: :created
    else
      render json: { errors: new_resume.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/resume/v1/resumes/:id
  def show
    render json: resume, include: :sections, status: :ok
  end

  # PUT /api/resume/v1/resumes/:id
  def update
    if resume.update(resume_params)
      render json: resume, status: :ok
    else
      render json: { errors: resume.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/resume/v1/resumes/:id
  def destroy
    resume.destroy
    render json: { message: 'Resume deleted successfully' }, status: :ok
  end

  private

  def resume
    @resume ||= current_user.resumes.includes(:sections).find_by!(id: params[:id])
  end

  def authorize_resume
    authorize resume
  end

  def resume_params
    params.require(:resume).permit(:title, :style, :content, sections_attributes: [:id, :title, :content, :_destroy])
  end
end
