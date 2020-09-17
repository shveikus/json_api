# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table(:users) do
      add_index :login
    end
  end
end
