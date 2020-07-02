# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Changelog, type: :model do
  subject { described_class.new(title: 'Hello friends!', text: 'WOOOW') }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'sets the slug after changing the title' do
    subject.title = 'This is a new title'
    expect(subject.slug).to eq('this-is-a-new-title')
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end
end
