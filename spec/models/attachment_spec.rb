# frozen_string_literal: true

require 'models_helper'

describe Attachment, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to organization' do
      expect(described_class.reflect_on_association(:organization).macro).to eq(:belongs_to)
    end

    context '#attachmentable' do
      subject { described_class.reflect_on_association(:attachmentable) }

      it 'belongs to attachmentable' do
        expect(subject.macro).to eq(:belongs_to)
      end

      it 'is polymorphic' do
        expect(subject.options[:polymorphic]).to be_truthy
      end

      it 'is optional' do
        expect(subject.options[:optional]).to be_truthy
      end
    end
  end

  it 'has mounted field :file' do
    expect(described_class.uploaders[:file]).to eq FileUploader
  end
end
