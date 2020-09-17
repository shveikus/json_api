class User < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :login, Types::String

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
