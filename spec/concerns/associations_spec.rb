# frozen_string_literal: true

require 'spec_helper'

shared_examples_for 'attachmentable' do
  subject { described_class.reflect_on_association(:attachments) }

  it 'has many attachments' do
    expect(subject.macro).to eq(:has_many)
  end

  it 'is polymorphic association' do
    expect(subject.options[:as]).to eq(:attachmentable)
  end
end

shared_examples_for 'videoable' do
  subject { described_class.reflect_on_association(:videos) }

  it 'has many videos' do
    expect(subject.macro).to eq(:has_many)
  end

  it 'is polymorphic association' do
    expect(subject.options[:as]).to eq(:videoable)
  end
end
