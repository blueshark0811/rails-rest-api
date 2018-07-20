class Api::V1::GroupUserSerializer < BaseSerializer
  include ApiSerializer

  # belongs_to :user

  attribute :user

  def user
    # in case of searchkick result
    res = object.is_a?(GroupUser) ? object.user : object.user_id && User.find(object.user_id)

    return unless res

    Api::V1::UserSerializer.new(res, serializer_params).as_json
  end
end
