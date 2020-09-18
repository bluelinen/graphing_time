class FriendOf
  include ActiveGraph::Relationship

  from_class :User
  to_class :User

end
