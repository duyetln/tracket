class CreateRulesTable < ActiveRecord::Migration
  def up
    create_table  :rules do |t|
      t.integer   :project_id, null: false
      t.integer   :field_id, null: false
      t.string    :type, null: false
      t.string    :prerequisite_type
      t.integer   :prerequisite_id
      t.string    :assertion_type
      t.integer   :assertion_id
      t.string    :string_value
      t.text      :text_value
      t.integer   :integer_value
      t.decimal   :decimal_value
      t.datetime  :date_time_value
      t.integer   :option_value
      t.timestamps null: false
    end

    add_index     :rules, :project_id

    add_foreign_key :rules, :projects
    add_foreign_key :rules, :fields
    add_foreign_key :rules, :options, column: :option_value
  end

  def down
    remove_foreign_key :rules, column: :option_value
    remove_foreign_key :rules, :fields
    remove_foreign_key :rules, :projects

    remove_index  :rules, :project_id
    drop_table    :rules
  end
end
