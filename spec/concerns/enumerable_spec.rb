# frozen_string_literal: true

require 'spec_helper'

shared_examples_for 'enumerable' do
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
      expect(subject[model_key].keys).to include(*fields.map{|f| (f.is_a?(Hash) ? f[:field] : f).to_s})
    end
  end

  describe '#enumerate' do
    def params(field)
      if field.is_a?(Hash)
        return { 
          field: field[:field], 
          prefix: field[:prefix] == true ? field[:field] : field[:prefix], 
          suffix: field[:suffix] == true ? field[:field] : field[:suffix], 
          set_default: field[:set_default] 
        }
      end

      { field: field, prefix: nil, suffix: nil, set_default: nil }
    end

    it 'should set enum field with string value instead number' do
      fields.each do |args|
        object.defined_enums[params(args)[:field].to_s].each do |_k, v|
          expect(v).to be_kind_of String
        end
      end
    end

    it 'should be added prefix/suffix to methods if passed' do
      fields.each do |args|
        values = object.defined_enums[params(args)[:field].to_s]

        mthd = [params(args)[:prefix], values.first.first, params(args)[:suffix]].compact.join('_')

        expect(object).to respond_to("#{mthd}?".to_sym)
        expect(object).to respond_to("#{mthd}!".to_sym)
      end
    end

    it 'should not set default value if passed set_default as false' do
      fields.each do |args|
        object.valid?
        if params(args)[:set_default] == false
          expect(object.send(params(args)[:field])).to be_nil
        else
          expect(object.send(params(args)[:field])).to_not be_nil
        end
      end
    end

    # def prepare_field val
    #   [val].inject({}){|h, w| h; h[w] = w; h}
    # end

    # context 'when sent only field name' do
    #   before do
    #     allow(model).to receive(:enumeration_labels).and_return enumerable_new_field
    #     model.send :attr_accessor, :enumerable_new_field
    #     model.enumerate :enumerable_new_field
    #   end

    #   describe 'prefix and sufix' do
    #     let(:enumerable_new_field) { prepare_field 'very_1_active' }

    #     it 'should be blank' do
    #       expect(model.new).to respond_to("#{enumerable_new_field.values.first}?".to_sym)
    #     end
    #   end

    #   describe 'default value' do
    #     let(:enumerable_new_field) { prepare_field 'very_2_active' }

    #     it 'should be set before validation' do
    #       obj = model.new

    #       expect(obj.enumerable_new_field).to be_nil
    #       obj.valid?
    #       expect(obj.enumerable_new_field).to eq enumerable_new_field.values.first
    #     end
    #   end
    # end

    # context 'when sent additional params' do
    #   before do
    #     allow(model).to receive(:enumeration_labels).and_return enumerable_new_field
    #     model.send :attr_accessor, :enumerable_new_field
    #     model.enumerate enumerable_params
    #   end

    #   describe 'prefix' do
    #     let(:prefix){ 'some_prefix' }
    #     let(:enumerable_new_field) { prepare_field('very_3_active') }
    #     let(:enumerable_params) { { field: :enumerable_new_field, prefix: prefix } }

    #     it 'should be added prefix to methods' do
    #       expect(model.new).to respond_to("#{prefix}_#{enumerable_new_field.values.first}?".to_sym)
    #     end
    #   end

    #   describe 'suffix' do
    #     let(:suffix){ 'some_suffix' }
    #     let(:enumerable_new_field) { prepare_field('very_4_active') }
    #     let(:enumerable_params) { { field: :enumerable_new_field, suffix: suffix } }

    #     it 'should be added suffix to methods' do
    #       expect(model.new).to respond_to("#{enumerable_new_field.values.first}_#{suffix}?".to_sym)
    #     end
    #   end

    #   describe 'default value' do
    #     let(:enumerable_new_field) { prepare_field('very_5_active') }
    #     let(:enumerable_params) { { field: :enumerable_new_field, set_default: false } }

    #     it 'should not be set before validation' do
    #       obj = model.new

    #       expect(obj.enumerable_new_field).to be_nil
    #       obj.valid?
    #       expect(obj.enumerable_new_field).to be_nil
    #     end
    #   end
    # end
  end
end
