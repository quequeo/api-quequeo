class Api::V1::Me::UploadsController < ApplicationController
  def presigned_url
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket('quequeo')
    bucket_object = bucket.object(params[:file_name])
    url = bucket_object.presigned_url(
      :post, 
      expires_in: 3600, 
      content_type: params[:file_type]
    )

    puts url

    render json: { url: url, fields: {} }
  end
end
