require 'models_helper'

describe CourseGroup, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { [{field: :complete_lesson_can, prefix: true}, :status] }
  end
end
