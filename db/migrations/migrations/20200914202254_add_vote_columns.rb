Hanami::Model.migration do
  change do
    alter_table :posts do
      add_column :votes, Integer, null: false, default: 0
      add_column :total_rating, Integer, null: false, default: 0
      add_column :avg_rating, Float, null: false, default: 0
    end
  end
end
