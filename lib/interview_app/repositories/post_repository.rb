class PostRepository < Hanami::Repository
  associations do
    has_one :rating
    belongs_to :user
  end

  def find_post(id)
    posts.where({id: id}).limit(1).map_to(Post).one
  end
end
