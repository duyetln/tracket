class CreateClausesTable < ActiveRecord::Migration
  def up
    create_table  :clauses do |t|
      t.string    :type, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table    :clauses
  end
end
