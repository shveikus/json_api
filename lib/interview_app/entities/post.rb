class User < Hanami::Entity
end

class Post < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :user_id, Types::Int
    attribute :user, Types::Entity(User)

    attribute :title, Types::String
    attribute :body, Types::String
    attribute :ip, Types::String
    attribute :votes, Types::Int
    attribute :total_rating, Types::Int
    attribute :avg_rating, Types::Float

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
