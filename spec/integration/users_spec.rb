require 'swagger_helper'
include ApiSpecHelper

describe Api::V1::UsersController do
  let!(:rswag_properties) { { current_user: current_user, object: current_user } }
  CURRENT_CLASS = User #need for description of actions
  it_behaves_like 'crud'
end
