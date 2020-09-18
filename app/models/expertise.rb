class Expertise
  include ActiveGraph::Relationship

  from_class :Heading
  to_class :User
end