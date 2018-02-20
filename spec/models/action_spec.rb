require 'models_helper'

describe Action, type: :model do
  let(:action){ create :action }

  it_behaves_like 'enumerable' do
    let(:fields) { %i[action_type] }
  end
end
