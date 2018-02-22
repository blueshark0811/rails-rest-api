require 'models_helper'

RSpec.describe Organization, type: :model do
  describe 'should validate' do
    let(:organization) { build :organization }
    it '..and factory should be valid' do
      expect(organization.valid?).to be_truthy
    end

    it 'presence title' do
      organization.title = nil
      organization.valid?
      expect(organization.errors[:title]).to_not be_blank
    end

    it 'presence of subdomain' do
      organization.subdomain = nil
      organization.valid?
      expect(organization.errors[:subdomain]).to_not be_blank
    end

    it 'format of subdomain' do
      organization.subdomain = '(*U&(Y'
      organization.valid?
      expect(organization.errors[:subdomain]).to_not be_blank
    end

    context 'domain' do
      it 'for format' do
        organization.domain = '(*U&(Y.com'
        organization.valid?
        expect(organization.errors[:domain]).to_not be_blank
      end

      it '... but it could be empty' do
        organization.domain = nil
        organization.valid?
        expect(organization.errors[:domain]).to be_blank
      end
    end
  end

  describe 'association' do
    it 'has many organization_users' do
      expect(described_class.reflect_on_association(:organization_users).macro).to eq(:has_many)
    end

    it 'has many groups' do
      expect(described_class.reflect_on_association(:groups).macro).to eq(:has_many)
    end

    it 'has many courses' do
      expect(described_class.reflect_on_association(:courses).macro).to eq(:has_many)
    end

    it 'has many videos' do
      expect(described_class.reflect_on_association(:videos).macro).to eq(:has_many)
    end

    it 'has many attachments' do
      expect(described_class.reflect_on_association(:attachments).macro).to eq(:has_many)
    end

    context '#users' do
      subject { described_class.reflect_on_association(:users) }

      it 'has many users' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association organization_users' do
        expect(subject.options[:through]).to eq :organization_users
      end
    end
  end
end
