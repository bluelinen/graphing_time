# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do # rubocop:disable Metrics/BlockLength
  context 'when created' do # rubocop:disable Metrics/BlockLength
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

    describe 'name' do
      it 'cannot be created without a name' do
        expect { described_class.create!(website: 'http://example.com') }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
      end
    end

    describe 'website address' do
      it 'cannot be created without a website address' do
        expect { described_class.create!(name: 'Luke Skywalker') }.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError)
      end

      it 'cannot be created with an invalid website address format' do
        expect { described_class.create!(name: 'Luke Skywalker', website: 'notarealwebsite')}.to raise_error(ActiveGraph::Node::Persistence::RecordInvalidError, 'Website Invalid website address')
      end
    end

    describe 'short website address' do
      let(:user_params) do
        { name: 'Darth Vader', website: 'https://death.star'}
      end

      it 'calls the link shortener' do
        allow(LinkShortener).to receive(:shorten_link).and_return('http://valid.link')
        described_class.create!(user_params)
        expect(LinkShortener).to have_received(:shorten_link).once
      end

      it 'saves the short website address to the user' do
        allow(LinkShortener).to receive(:shorten_link).with('https://death.star').and_return('http://valid.link').once
        user = described_class.create!(user_params)
        expect(user.short_website).to eq('http://valid.link')
      end
    end

    describe "it visits the user's website" do
      let(:user_params) do
        { name: 'Darth Vader', website: 'https://death.star'}
      end

      it 'runs a heading extractor callback' do
        expect_any_instance_of(HeadingExtractor).to receive(:get)
        described_class.create!(user_params)
      end

      it 'saves the headings into the user' do
        user = described_class.create!(user_params)
        expect(user.headings.pluck(:name)).to include("This is a H3", "This is a H2", "This is a H1")
      end
    end
  end
end
