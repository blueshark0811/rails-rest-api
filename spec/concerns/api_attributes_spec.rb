require 'rails_helper'

shared_examples_for 'apiattributable' do
  let(:model) { described_class } # the class that includes the concern
  let(:model_key) { described_class.name.underscore }
  let(:object) { create model_key }

  describe '#api_attributes_for_swagger' do
    let(:options) { { data_action: :return } }
    subject { object.api_attributes_for_swagger options }

    context 'when :return attributes asked' do
      it 'gets attributes from serializer' do
        expect(object).to receive(:api_return_attributes).with(options)
        subject
      end
    end

    context 'when :receive attributes asked' do
      let(:options) { { data_action: :receive } }
      it 'gets attributes from policy' do
        expect(object).to receive(:api_receive_attributes).with(options)
        subject
      end
    end

    context 'when serializer return no attributes' do
      before do
        allow(object).to receive(:api_return_attributes).and_return []
      end

      it { is_expected.to eq({}) }
    end

    context 'when serializer return attributes' do
      let(:fields) { {'id' => { 'type' => :integer }, 'email' => { 'type' => :string } } }
      let(:api_return_attributes) { fields.keys.map(&:to_sym) }

      before do
        allow(object).to receive(:api_return_attributes).and_return api_return_attributes
        allow(object).to receive(:attributes).and_return fields
      end

      it 'returns hash with fields information' do
        expect(subject).to eq fields
      end

      it 'is with indifferent access' do
        expect(subject[fields.keys.last.to_s]).to_not be_nil
        expect(subject[fields.keys.last.to_sym]).to_not be_nil
      end
    end
  end

  describe '.additional_attributes' do
    subject { model.additional_attributes }
    it { is_expected.to be_kind_of Hash }
  end

  describe '#column_of_attribute' do
    let(:attribute) { :id }
    subject { model.column_of_attribute attribute }

    context 'when attribute is from base fields' do
      it 'returns PostgreSQLColumn data' do
        is_expected.to be_kind_of(ActiveRecord::ConnectionAdapters::PostgreSQLColumn)
      end
    end

    context 'when attribute is not from base fields' do
      let(:attribute) { :some_other }
      let(:additional_attributes) { { some_other: { type: :string } } }

      before do
        allow(model).to receive(:additional_attributes).and_return additional_attributes
      end

      it 'returns OpenStruct data' do
        is_expected.to be_kind_of(OpenStruct)
      end
    end

    context 'when attribute is from base fields but there is additional description for it' do
      let(:attribute) { :id }
      let(:additional_attributes) { {id: { type: :string } } }

      before do
        allow(model).to receive(:additional_attributes).and_return additional_attributes
      end

      it 'returns OpenStruct data' do
        is_expected.to be_kind_of(OpenStruct)
      end

      it 'returns data form additional_attributes, not from base column info' do
        expect(subject[:type]).to eq additional_attributes[:id][:type]
      end
    end
  end

  describe '#api_base_attributes' do
    subject { object.api_base_attributes }

    context 'when searchkick mounted to model' do
      let(:search_data) { { new_attribute: 1 } }

      before do
        if object.respond_to?(:search_data)
          allow(object).to receive(:search_data).and_return(search_data)
        else
          object.define_singleton_method :search_data { search_data }
        end
      end

      it 'returns base attributes + search_data' do
        res = (object.attributes.keys+search_data.keys).map(&:to_sym).sort
        expect(subject.sort).to eq res
      end
    end

    context 'when searchkick is not mounted to model' do
      before do
        allow(object).to receive(:respond_to?).with(:search_data).and_return(false)
      end

      it 'returns base attributes' do
        res = object.attributes.keys.map(&:to_sym).sort
        expect(subject.sort).to eq res
      end
    end
  end

  describe '#policy_available_attribute' do
    let(:user_context) { build :user_context }
    subject { object.policy_available_attribute user_context, :index }

    context 'when policy class is not found' do
      before { allow(model).to receive(:policy_klass).and_return(nil) }

      it { is_expected.to eq [] }
    end

    context 'when policy class is exist' do
      before { allow(model).to receive(:policy_klass).and_return(ApplicationPolicy) }

      it 'gets from policy attirbutes' do
        expect(ApplicationPolicy).to receive_message_chain :new, :api_attributes
        subject
      end
    end
  end

  describe '.serializer_class_name' do
    subject { model.serializer_class_name }

    it 'returns serializer name for current model' do
      expect(subject).to eq "Api::V#{API_VERSION}::#{model.name}Serializer"
    end
  end

  describe '.serializer_file' do
    subject { model.serializer_file }

    it 'returns serializer file path for current model and api version' do
      expect(subject.to_s).to match(/app\/serializers\/api\/v#{API_VERSION}\/#{model.name.underscore}_serializer\.rb/)
    end
  end

  describe '.policy_file' do
    subject { model.policy_file }

    it 'returns policy file path for current model' do
      expect(subject.to_s).to match(/app\/policies\/#{model.name.underscore}_policy\.rb/)
    end
  end

  describe '.policy_klass' do
    subject { model.policy_klass }

    # it 'tries to require policy file' do
    #   expect(File).to receive(:exist?).with model.policy_file
    #   #expect(Kernel).to receive(:require)
    #   subject
    # end

    it 'returns child class of ApplicationPolicy' do
      expect(subject.ancestors).to include ApplicationPolicy
    end
  end

  describe '.policy_base_attributes' do
    let(:user_context) { UserContext.new }
    subject { model.policy_base_attributes }

    context 'when policy class is not found' do
      before { allow(model).to receive(:policy_klass).and_return(nil) }

      it { is_expected.to eq [] }
    end

    context 'when policy class is exist' do
      before { allow(model).to receive(:policy_klass).and_return(ApplicationPolicy) }

      it 'gets from policy attirbutes' do
        expect(ApplicationPolicy).to receive_message_chain(:new, :api_attributes)
        subject
      end
    end
  end

  describe '.serializer' do
    subject { model.serializer }

    it 'tries to require serializer file' do
      expect(File).to receive(:exist?).with model.serializer_file
      #expect(Kernel).to receive(:require)
      subject
    end

    xit 'checks that class exist' do
      expect(Object).to receive(:const_defined?).with model.serializer_class_name
      subject
    end

    it 'returns child class of ActiveModel::Serializer' do
      expect(subject.ancestors).to include ActiveModel::Serializer
    end
  end

  describe '.api_prepare_attributes_for_swagger' do
    let(:options) { {} }
    let(:simple_field) { :id }
    let(:attributes_for_assoc) { { group_attributes: [:id] } }
    let(:attributes) { [simple_field, attributes_for_assoc] }
    subject { model.api_prepare_attributes_for_swagger attributes, options }

    it 'returns properties of simple fields like id' do
      expect(model).to receive(:api_prepare_attribute_for_swagger).with(simple_field, options)
      subject
    end

    it 'returns properties of attributes for association' do
      expect(subject[attributes_for_assoc.keys.first]).to be_kind_of Hash
      expect(subject[attributes_for_assoc.keys.first][:type]).to eq :array
    end

    it 'returns properties of each attribute of association that passed' do
      expect(subject.dig(attributes_for_assoc.keys.first, :items, :properties)).to eq(
        model.api_prepare_attributes_for_swagger(attributes_for_assoc.values.first, options)
      )
    end
  end

  describe '.api_prepare_attribute_for_swagger' do
    let(:options) { {} }
    let(:field) { :id }
    let(:dbl) { double }
    subject { model.api_prepare_attribute_for_swagger field, options }

    it 'contains type of field' do
      expect(subject[:type]).to_not be_nil
    end

    it 'sets type :string if there is no info about type of attribute' do
      allow(model).to receive(:column_for_attribute).and_return(dbl)
      allow(dbl).to receive(:type).and_return nil
      allow(dbl).to receive(:null).and_return true

      expect(subject[:type]).to eq :string
    end

    context 'when field is ids of specific association' do
      let(:field) { :group_ids }
      before do
        if object.respond_to?(:group_ids)
          allow(object).to receive(:group_ids).and_return([1,2,3])
        else
          object.define_singleton_method :group_ids { [1,2,3] }
        end
      end

      it 'returns type as an array' do
        expect(subject[:type]).to eq :array
      end
    end

    context 'when field is enum' do
      let(:field) { model.defined_enums.keys.first }

      it 'contains enum posible values' do
        expect(subject[:enum]).to eq model.defined_enums[field].values
      end
    end

    context 'when field is mounted as carriwave uploader' do
      let(:field) { model.uploaders.keys.first }

      it 'has type :object' do
        expect(subject[:type]).to eq :object
      end
    end

    context 'when field could be nil' do
      it 'contains x-nullable param' do
        allow(model).to receive(:column_for_attribute).and_return(dbl)
        allow(dbl).to receive(:type).and_return :string
        allow(dbl).to receive(:null).and_return true

        expect(subject['x-nullable']).to_not be_nil
      end
    end

    context 'when field could not be nil' do
      let(:dbl) { double }

      it 'contains x-nullable param' do
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
