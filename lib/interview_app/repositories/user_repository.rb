class UserRepository < Hanami::Repository

  associations do
    has_many :posts
  end

  def already_exist?(login)
    users.where({login: login}).limit(1).map_to(User).one
  end
end
