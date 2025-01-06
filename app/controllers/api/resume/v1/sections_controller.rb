class Api::Resume::V1::SectionsController < Api::Resume::ApplicationController
  after_action :verify_authorized

  # POST /api/resume/v1/resumes/:resume_id/sections
  def create
    resume = current_user.resumes.find(params[:resume_id])
    authorize resume

    section = resume.sections.new(section_params)
    authorize section

    if section.save
      render json: section, status: :created
    else
      render json: { errors: section.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/resume/v1/sections/:id
  def update
    section = Section.find(params[:id])
    authorize section

    if section.update(section_params)
      render json: section, status: :ok
    else
      render json: { errors: section.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/resume/v1/sections/:id
  def destroy
    section = Section.find(params[:id])
    authorize section

    if section.destroy
      render json: { message: 'Section deleted successfully' }, status: :ok
    else
      render json: { errors: section.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def section_params
    params.require(:section).permit(:title, :content)
  end
end
