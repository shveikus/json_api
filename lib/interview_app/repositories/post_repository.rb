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
end
