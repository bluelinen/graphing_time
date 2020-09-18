# frozen_string_literal: true

require 'rails_helper'
require 'heading_extractor'

describe HeadingExtractor do
  describe 'extract_headings' do
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
      allow_any_instance_of(HeadingExtractor)
        .to receive(:get).and_return(sample_body)
    end

    it 'extracts headings from a link' do
      heading_extractor = HeadingExtractor.new('https://www.example.com')
      expect(heading_extractor.headings).to include('This is a H1')
      expect(heading_extractor.headings).to include('This is a H2')
      expect(heading_extractor.headings).to include('This is a H3')
      expect(heading_extractor.headings).not_to include('This is a H4')
    end
  end
end
