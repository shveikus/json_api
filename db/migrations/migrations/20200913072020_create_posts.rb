Hanami::Model.migration do
  change do
    create_table :posts do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade, null: false

      column :title, String, null: false, text: true
      column :body, String, null: false, text: true
      column :ip, String, text: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
