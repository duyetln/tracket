class CreateRulesTable < ActiveRecord::Migration
  def up
    create_table  :rules do |t|
      t.integer   :project_id, null: false
      t.string    :prerequisite_type
      t.integer   :prerequisite_id
      t.string    :assertion_type
      t.integer   :assertion_id
      t.timestamps null: false
    end

    add_index :rules, :project_id

    add_foreign_key :rules, :projects
  end

  def down
    remove_foreign_key :rules, :projects

    remove_index  :rules, :project_id
    drop_table    :rules
  end
end
