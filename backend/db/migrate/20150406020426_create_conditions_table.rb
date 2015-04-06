class CreateConditionsTable < ActiveRecord::Migration
  def up
    create_table  :conditions do |t|
      t.integer   :clause_id, null: false
      t.integer   :field_id, null: false
      t.string    :type, null: false
      t.boolean   :inversed, default: false
      t.string    :string_value
      t.text      :text_value
      t.integer   :integer_value
      t.decimal   :decimal_value
      t.datetime  :date_time_value
      t.integer   :option_value
      t.timestamps null: false
    end

    add_index     :conditions, :clause_id

    add_foreign_key :conditions, :clauses
    add_foreign_key :conditions, :fields
    add_foreign_key :conditions, :options, column: :option_value
  end

  def down
    remove_foreign_key :conditions, column: :option_value
    remove_foreign_key :conditions, :fields
    remove_foreign_key :conditions, :clauses

    remove_index  :conditions, :clause_id
    drop_table    :conditions
  end
end
