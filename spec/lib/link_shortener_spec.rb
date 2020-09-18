require 'rails_helper'
require 'link_shortener'

describe LinkShortener do
  it 'provides a bit.ly shortened link' do
    short_link = LinkShortener.shorten_link('https://www.example.com')
    uri = URI.parse(short_link)
    expect(uri.host).to eq('bit.ly')
  end
end
