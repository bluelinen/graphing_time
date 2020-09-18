class CreateHeading < ActiveGraph::Migrations::Base
  def up
    add_constraint :Heading, :uuid
  end

  def down
    drop_constraint :Heading, :uuid
  end
end
