require 'swagger_helper'

describe Api::V1::ActivitiesController do
  let(:notifiable) { current_user }
  let(:activity) { create :activity, notifiable: notifiable }
  let!(:rswag_properties) do {
    current_user: current_user,
    current_organization: current_user.organizations.first,
    object: activity
    }
  end
  let(:notifiable_id) { notifiable.id }
  let(:notifiable_type) { notifiable.class.name }

  options = {
    klass: Activity,
    slug: '{notifiable_type}/{notifiable_id}/activities',
    additional_parameters: [{
      name: :notifiable_id,
      in: :path,
      type: :integer,
      required: true
    }, {
      name: :notifiable_type,
      in: :path,
      type: :string,
      required: true,
      enum: Activity::NOTIFIABLES
    }] }

  crud_index options.merge(description: 'Activity')
  crud_update options.merge(description: 'Update status of Activity')
  crud_delete options.merge(description: 'Delete Activity')
end
