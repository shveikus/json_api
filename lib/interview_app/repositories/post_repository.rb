class PostRepository < Hanami::Repository
  associations do
    belongs_to :user
  end

  def find_post(id)
    posts.where({ id: id }).limit(1).map_to(Post).one
  end

  def find_by_top_rating(top)
    posts.order { avg_rating.desc }.limit(top[:top])
  end

  def find_by_top_rating(top)
    posts.order { avg_rating.desc }.limit(top[:top])
  end

  def update_avg_rating(payload)
    post_relation = posts.where(id: payload[:post_id])
    post_relation.lock do
      post = post_relation.map_to(Post).one
      total_rating = post.total_rating + payload[:user_rate]
      votes = post.votes + 1
      avg_rating = total_rating / votes
      new_post = ::Post.new({ total_rating: total_rating, votes: votes, avg_rating: avg_rating })
      update(post.id, new_post)
    end
  end
end
