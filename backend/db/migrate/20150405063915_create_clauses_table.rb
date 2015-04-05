class CreateClausesTable < ActiveRecord::Migration
  def up
    create_table  :clauses do |t|
      t.integer   :parent_id
      t.string    :type, null: false
      t.boolean   :inversed, default: false
      t.timestamps null: false
    end

    add_index     :clauses, :parent_id

    add_foreign_key :clauses, :clauses, column: :parent_id
  end

  def down
    remove_foreign_key :clauses, column: :parent_id

    remove_index  :clauses, :parent_id
    drop_table    :clauses
  end
end
