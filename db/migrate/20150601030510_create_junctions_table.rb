class CreateJunctionsTable < ActiveRecord::Migration
  def up
    create_table  :junctions do |t|
      t.integer   :parent_clause_id, null: false
      t.integer   :clause_id
      t.integer   :condition_id
    end

    add_index     :junctions, :parent_clause_id
  end

  def down
    remove_index  :junctions, :parent_clause_id

    drop_table    :junctions
  end
end
