class ExpertiseSearch
  def initialize(user, expertise_name)
    @user = user
    @name = expertise_name
  end

  # param n is used to determine search results to return
  def search(n = 5)

    queue = Queue.new
    queue << {user: @user, path: []}
    num_found = 0
    experts_remaining = experts
    results = []
    visited_nodes = {}

    while(queue.present? && experts_remaining.present? && num_found < n) do
      current_user_node = queue.pop
      if experts[current_user_node[:user][:uuid]]
        experts_remaining.delete(current_user_node[:user][:uuid])
        num_found += 1
        path = current_user_node[:path].dup
        path << current_user_node[:user][:uuid]
        results << {user: current_user_node[:user], path: path}
        visited_nodes[current_user_node[:user][:uuid]] = true
      end

      current_user_node[:user].friends.each do |friend|
        next if visited_nodes[friend.uuid]
        path = current_user_node[:path].dup
        path << current_user_node[:user][:uuid]
        queue << {user: friend, path: path}
      end
    end
    results
  end

  private

  def experts
    return @experts unless @experts.nil?

    heading = Heading.find_by(name: @name)
    return [] if heading.nil?

    @experts = {}
    heading.experts.each do |expert|
      @experts[expert.uuid] = expert
    end

    @user.friends.each do |friend|
      @experts.delete(friend[:uuid])
    end
    @experts
  end
end