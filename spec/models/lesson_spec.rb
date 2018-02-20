require 'models_helper'

describe Lesson, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { %i[status] }
  end
end
