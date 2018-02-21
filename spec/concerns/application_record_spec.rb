require 'rails_helper'

shared_examples_for 'activerecordable' do
  let(:model) { described_class } # the class that includes the concern
  let(:model_key) { described_class.name.underscore }
  let(:object) { create model_key }

  describe '.attributes' do
    subject { model.attributes }

    it { is_expected.to be_kind_of Array }

    it 'should contain fields of model as symobls' do
      expect(subject).to include :id
    end
  end

  describe '#error_keys' do
    let(:field) { model.attributes.first }

    subject { object.error_keys field }

    context 'when no errors' do
      it { is_expected.to eq [] }
    end

    context 'when errors exist' do
      let(:error_key) { :invalid }

      before do
        object.errors.add(field, error_key)
      end

      it 'should contain error keys for specific field like :invalid, :taken...' do
        expect(subject).to include error_key
      end
    end
  end
end

describe User, type: :model do #testing activerecordable based User model
  it_behaves_like 'activerecordable'
end
