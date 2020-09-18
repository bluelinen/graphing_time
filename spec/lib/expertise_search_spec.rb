# frozen_string_literal: true

require 'rails_helper'
require 'expertise_search'

describe ExpertiseSearch do # rubocop:disable Metrics/BlockLength
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

  context 'a simple graph' do
    (1..4).each do |i|
      let(:"u#{i}") { create(:user) }
    end
    before do
      FriendOf.create(from_node: u1, to_node: u2)
      FriendOf.create(from_node: u1, to_node: u4)
      FriendOf.create(from_node: u2, to_node: u3)
    end

    it 'finds the expert correctly' do
      heading = Heading.create!(name: 'superman')
      Expertise.create(from_node: heading, to_node: u3)
      es = ExpertiseSearch.new(u1, 'superman')
      result = es.search
      expect(result.count).to eq(1)
      expect(result.last[:user]).to eq(u3)
      expect(result.last[:path]).to eq([u1.uuid, u2.uuid, u3.uuid])
    end
  end
end