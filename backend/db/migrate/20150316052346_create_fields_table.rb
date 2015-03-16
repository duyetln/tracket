class CreateFieldsTable < ActiveRecord::Migration
  def up
    create_table  :fields do |t|
      t.integer   :project_id
      t.string    :name
      t.string    :type
      t.timestamps null: false
    end

    add_index     :fields, :project_id

    add_foreign_key :fields, :projects
  end

  def down
    remove_foreign_key :fields, :projects

    remove_index  :fields, :project_id
    drop_table    :fields
  end
end
