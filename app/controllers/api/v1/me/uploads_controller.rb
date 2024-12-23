class Api::V1::Me::UploadsController < Api::ApplicationMeController
  def presigned_url
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket("#{ENV["AWS_S3_BUCKET_NAME"]}")
    bucket_object = bucket.object(params[:file_name])
    url = bucket_object.presigned_url(
      :put, 
      expires_in: 3600, 
      content_type: params[:file_type]
    )

    puts url

    render json: { url: url }, status: :ok
  end
end
