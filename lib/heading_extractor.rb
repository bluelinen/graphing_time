class HeadingExtractor
  attr_reader :headings

  def initialize(link)
    body = get(link)

    @doc = Nokogiri::HTML(body)

    @headings = []
    %w(h1 h2 h3).each do |heading|
      @headings += extract_heading(heading)
    end
  end

  def get(link)
    uri = URI(link)
    body = Net::HTTP.get(uri)
  end

  private

  def extract_heading(heading)
    results = @doc.xpath("//#{heading}")
    results.map { |result| result.text }
  end
end
