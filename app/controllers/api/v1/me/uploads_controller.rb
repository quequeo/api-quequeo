class Api::V1::Me::UploadsController < ApplicationController
  def presigned_url
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket('arn:aws:s3:::quequeo')
    obj = bucket.object(params[:file_name])

    url = obj.presigned_url(:put, expires_in: 3600, content_type: params[:content_type])

    render json: { url: url }
  end
end
