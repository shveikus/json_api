class Rating < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :value, Types::Float

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end
end
