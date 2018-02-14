require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe "should validate" do
    let(:organization) { build :organization }
    it "..and factory should be valid" do
      expect(organization.valid?).to be_truthy
    end

    it "presence title" do
      organization.title = nil
      organization.valid?
      expect(organization.errors[:title]).to_not be_blank
    end

    it "presence of subdomain" do
      organization.subdomain = nil
      organization.valid?
      expect(organization.errors[:subdomain]).to_not be_blank
    end

    it "format of subdomain" do
      organization.subdomain = '(*U&(Y'
      organization.valid?
      expect(organization.errors[:subdomain]).to_not be_blank
    end

    context "domain" do
      it "for format" do
        organization.domain = '(*U&(Y.com'
        organization.valid?
        expect(organization.errors[:domain]).to_not be_blank
      end

      it "... but it could be empty" do
        organization.domain = nil
        organization.valid?
        expect(organization.errors[:domain]).to be_blank
      end
    end
  end

  describe "association" do

  end
end
