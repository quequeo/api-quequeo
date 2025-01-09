
class Api::Resume::V1::ResumesController < Api::Resume::ApplicationController
  after_action :verify_authorized, except: %i[index create styles]
  before_action :authorize_resume, only: %i[show update destroy]

  # GET /api/resume/v1/resumes
  def index
    resumes = current_user.resumes.includes([:personal_informations, :work_experiences])
    render json: resumes, include: [:personal_informations, :work_experiences], status: :ok
  end

  # POST /api/resume/v1/resumes
  def create
    new_resume = current_user.resumes.new(resume_params)
    authorize new_resume

    if new_resume.save
      render json: new_resume, include: [:personal_informations, :work_experiences], status: :created
    else
      render json: { errors: new_resume.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/resume/v1/resumes/:id
  def show
    render json: resume, include: [:personal_informations, :work_experiences], status: :ok
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

  def styles
    render json: Resume::STYLES.keys, status: :ok
  end

  private

  def resume
    @resume ||= current_user.resumes.includes([:personal_informations, :work_experiences]).find_by!(id: params[:id])
  end

  def authorize_resume
    authorize resume
  end

  def resume_params
    params.require(:resume).permit(
      :title, :style, 
      personal_informations_attributes: [:id, :content, :_destroy],
      work_experiences_attributes: [:id, :content, :_destroy]
    )
  end
end
