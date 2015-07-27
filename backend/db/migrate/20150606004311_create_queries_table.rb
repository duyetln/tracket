class CreateQueriesTable < ActiveRecord::Migration
  def up
    create_table  :queries do |t|
      t.integer   :project_id, null: false
      t.string    :identifier, null: false
      t.string    :criterion_type, null: false
      t.integer   :criterion_id, null: false
      t.timestamps null: false
    end

    add_index     :queries, :project_id

    add_foreign_key :queries, :projects
  end

  def down
    remove_foreign_key :queries, :projects

    remove_index  :queries, :project_id
    drop_table    :queries
  end
end
