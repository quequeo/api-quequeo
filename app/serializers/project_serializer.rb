class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo_url

  def logo_url
    return nil unless object.logo.attached?

    Rails.application.routes.url_helpers.rails_blob_url(object.logo, host: Rails.application.routes.default_url_options[:host])
  end
end
