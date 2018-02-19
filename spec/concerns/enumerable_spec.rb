require 'spec_helper'

shared_examples_for "enumerable" do
  let(:model) { described_class } # the class that includes the concern
  let(:model_key) { described_class.name.underscore }
  let(:object) { create model_key.to_sym }
  let(:fields) { [:status] }

  describe '@@enumerate_fields' do
    subject { model.class_variable_get :@@enumerate_fields }

    it 'should have class variable enumerate_fields' do
      expect(model.class_variable_defined?(:@@enumerate_fields)).to be_truthy
    end

    it 'should contain data about model enumerable fields' do
      expect(subject.keys).to include(model_key)
      expect(subject[model_key].keys).to include(*fields.map(&:to_s))
    end
  end

  describe '#enumerate' do
    it 'should set enum field with string value instead number' do
      fields.each do |field|
        object.defined_enums[field.to_s].each do |k, v|
          expect(v).to be_kind_of String
        end
      end
    end

    context 'when sent only field name' do
      let(:enumerable_new_field) { {'very_active' => 'very_active'} }

      before do
        allow(model).to receive(:enumeration_labels).and_return enumerable_new_field
        model.send :attr_accessor, :enumerable_new_field
        model.enumerate :enumerable_new_field
      end

      it 'should have not prefix pr sufix for enum methods' do
        expect(model).to respond_to(:very_active?)
      end

      it 'should set default values before validation' do
        obj = model.new 
        expect(obj.enumerable_new_field).to be_nil
        obj.valid?
        expect(obj.enumerable_new_field).to eq 'very_active'
      end
    end

    context 'when sent additional params' do
      it 'should set prefix for enum scopes' do
      end

      it 'should set suffix for enum scopes' do
      end

      it 'should disable setting default values' do
      end
    end

  end
end
