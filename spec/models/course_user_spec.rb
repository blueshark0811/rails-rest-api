require 'models_helper'

describe CourseUser, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { %i[status] }
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to course' do
      expect(described_class.reflect_on_association(:course).macro).to eq(:belongs_to)
    end
  end
end
