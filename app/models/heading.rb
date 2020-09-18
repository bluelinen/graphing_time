class Heading
  include ActiveGraph::Node
  # id_property :personal_id, :name
  property :name, type: String

  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :out, :experts, rel_class: :Expertise, unique: true
end