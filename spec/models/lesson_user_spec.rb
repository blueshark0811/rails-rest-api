require 'models_helper'

describe LessonUser, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { %i[status] }
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to lesson' do
      expect(described_class.reflect_on_association(:lesson).macro).to eq(:belongs_to)
    end
  end
end
