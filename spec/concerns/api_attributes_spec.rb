require 'rails_helper'

shared_examples_for 'apiattributable' do
  let(:model) { described_class } # the class that includes the concern
  let(:model_key) { described_class.name.underscore }
  let(:object) { create model_key }

  describe '#api_properties_for_swagger' do
    subject { object.api_properties_for_swagger }

    context 'when serializer return no attributes' do
      before do
        allow(object).to receive(:api_available_attriubtes).and_return []
      end

      it { is_expected.to eq({}) }
    end

    context 'when serializer return attributes' do
      let(:fields) { {'id' => { 'type' => :integer }, 'email' => { 'type' => :string } } }
      let(:api_available_attriubtes) { fields.keys.map(&:to_sym) }

      before do
        allow(object).to receive(:api_available_attriubtes).and_return api_available_attriubtes
        allow(object).to receive(:attributes).and_return fields
      end

      it 'should return hash with fields information' do
        expect(subject).to eq fields
      end

      it 'should be with indifferent access' do
        expect(subject[fields.keys.last.to_s]).to_not be_nil
        expect(subject[fields.keys.last.to_sym]).to_not be_nil
      end

      context 'with that are not exist in model' do
        let(:api_available_attriubtes) { (fields.keys+[:some_other]).map(&:to_sym) }

        it 'should return hash with existing fields in model' do
          expect(subject).to eq fields
        end
      end
    end
  end

  xdescribe '#api_base_attributes'

  describe '.serializer_class_name' do
    subject { model.serializer_class_name }

    it 'should return serializer name for current model' do
      expect(subject).to eq "Api::V#{API_VERSION}::#{model.name}Serializer"
    end
  end

  describe '.serializer_file' do
    subject { model.serializer_file }

    it 'should return serializer file path for current model and api version' do
      expect(subject.to_s).to match(/app\/serializers\/api\/v#{API_VERSION}\/#{model.name.underscore}_serializer\.rb/)
    end
  end

  describe '.serializer' do
    subject { model.serializer }

    it 'should try to require serializer file' do
      expect(File).to receive(:exist?).with model.serializer_file
      #expect(Kernel).to receive(:require)
      subject
    end

    xit 'should check that class exist' do
      expect(Object).to receive(:const_defined?).with model.serializer_class_name
      subject
    end

    it 'should return child class of ActiveModel::Serializer' do
      expect(subject.ancestors).to include ActiveModel::Serializer
    end
  end

  describe '.api_prepare_property' do
    let(:field) { :id }
    let(:dbl) { double }
    subject { model.api_prepare_property field }

    it 'should contain type of field' do
      expect(subject[:type]).to_not be_nil
    end

    it 'should set type :string if there is no info about type of attribute' do
      allow(model).to receive(:column_for_attribute).and_return(dbl)
      allow(dbl).to receive(:type).and_return nil
      allow(dbl).to receive(:null).and_return true

      expect(subject[:type]).to eq :string
    end

    context 'when field is enum' do
      let(:field) { model.defined_enums.keys.first }

      it 'should contain enum posible values' do
        expect(subject[:enum]).to eq model.defined_enums[field].values
      end
    end

    context 'when field is mounted as carriwave uploader' do
      let(:field) { model.uploaders.keys.first }

      it 'should have type :object' do
        expect(subject[:type]).to eq :object
      end
    end

    context 'when field could be nil' do
      it 'should contain x-nullable param' do
        allow(model).to receive(:column_for_attribute).and_return(dbl)
        allow(dbl).to receive(:type).and_return :string
        allow(dbl).to receive(:null).and_return true

        expect(subject['x-nullable']).to_not be_nil
      end
    end

    context 'when field could not be nil' do
      let(:dbl) { double }

      it 'should contain x-nullable param' do
        allow(model).to receive(:column_for_attribute).and_return(dbl)
        allow(dbl).to receive(:type).and_return :string
        allow(dbl).to receive(:null).and_return false

        expect(subject['x-nullable']).to be_nil
      end
    end
  end
end

describe User, type: :model do #testing based on User model
  it_behaves_like 'apiattributable'
end
