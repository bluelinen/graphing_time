module LinkShortener
  def self.shorten_link(link)
    client = Bitly::API::Client.new(token: BITLY_TOKEN)
    bitlink = client.shorten(long_url: link)
    bitlink.link
  end
end
