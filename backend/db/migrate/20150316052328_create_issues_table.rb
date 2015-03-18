class CreateIssuesTable < ActiveRecord::Migration
  def up
    create_table  :issues do |t|
      t.integer   :project_id, null: false
      t.integer   :number, null: false
      t.string    :name, null: false
      t.text      :description
      t.timestamps null: false
    end

    add_index     :issues, :number

    add_foreign_key :issues, :projects
  end

  def down
    remove_foreign_key :issues, :projects

    remove_index  :issues, :number
    drop_table    :issues
  end
end
