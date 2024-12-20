class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :avatar_url

  def avatar_url
    object.send :avatar_url
  end
end
