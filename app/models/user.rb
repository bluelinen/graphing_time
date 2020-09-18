class User 
  include ActiveGraph::Node
  property :name, type: String
  property :website, type: String
  property :short_website, type: String

  validates :name, presence: true
  validates :website,
            presence: true,
            format: { with: %r(\Ahttps?://), message: 'Invalid website address'}

  has_many :both, :friends, rel_class: :FriendOf, unique: true
  has_many :in, :headings, rel_class: :Expertise, unique: true

  after_create do
    self.short_website = LinkShortener.shorten_link(self.website)
    save!

    heading_extractor = HeadingExtractor.new(self.website)
    heading_extractor.headings.each do |heading_name|
      heading = Heading.find_or_create_by!(name: heading_name)
      Expertise.create!(from_node: heading, to_node: self)
    end
  end

  def to_json_display(action = :index)
    result = {
      name: name,
      short_url: short_website
    }
    if action == :index
      result[:number_of_friends] = friends.count
    elsif action == :show
      result[:website] = website
      result[:headings] = headings.map {|h| h.name}
      result[:friend_links] = friends.map {|f| f.website}
    end
    result
  end

  def self.to_json_display
    all.map {|u| u.to_json_display }
  end

  def add_heading(heading_name)
    heading = Heading.find_or_create_by!(name: heading_name)
    Expertise.create!(from_node: heading, to_node: self)
    heading
  end

  def add_friend(friend_id)
    friend = User.find(friend_id)
    return false if friend.nil?

    FriendOf.create!(from_node: self, to_node: friend)
    friend
  end

  def search(expertise_name)
    es = ExpertiseSearch.new(self, expertise_name)
    es.search
  end
end
