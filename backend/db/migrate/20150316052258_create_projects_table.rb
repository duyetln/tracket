class CreateProjectsTable < ActiveRecord::Migration
  def up
    create_table  :projects do |t|
      t.string    :name, null: false
      t.text      :description
      t.timestamps null: false
    end
  end

  def down
    drop_table  :projects
  end
end
