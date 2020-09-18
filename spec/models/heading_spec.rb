# frozen_string_literal: true

require 'rails_helper'

describe Heading, type: :model do # rubocop:disable Metrics/BlockLength
  context 'when created' do
    it 'can be created successfully' do
      heading = described_class.create!(name: 'some name')
      expect(heading.persisted?).to be true
    end

    it 'fails if no name is provided' do
      expect { described_class.create! }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError, "Name can't be blank")
    end

    it 'fails if a second heading with the same name is created' do
      expect { 2.times { described_class.create!(name: 'heading') }}.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
    end
  end

  context 'when linking' do
    let(:sample_body) do
      <<~HTML
      <html><body>
        <h1>This is a H1</h1>
        <h3>This is a H3</h3>
        <h2>This is a H2</h2>
        <h4>This is a H4</h4>
      </body></html>
      HTML
    end

    before do
      allow(LinkShortener).to receive(:shorten_link).and_return('https://bit.ly/test')
      allow_any_instance_of(HeadingExtractor).to receive(:get).and_return(sample_body)
    end

    let(:user) { FactoryBot.create(:user) }
    let(:heading) { FactoryBot.create(:heading) }
    it 'can be linked to a user' do
      Expertise.create!(from_node: heading, to_node: user)
    end
  end
end