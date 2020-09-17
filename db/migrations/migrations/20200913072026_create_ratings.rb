Hanami::Model.migration do
  change do
    create_table :ratings do
      primary_key :id
      foreign_key :post_id, :posts, on_delete: :cascade, null: false

      column :value, Float, null: false, default: 3.0

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
