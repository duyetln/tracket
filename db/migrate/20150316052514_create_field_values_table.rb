class CreateFieldValuesTable < ActiveRecord::Migration
  def up
    create_table  :field_values do |t|
      t.integer   :issue_id, null: false
      t.integer   :field_id, null: false
      t.string    :string_value
      t.text      :text_value
      t.integer   :integer_value
      t.decimal   :decimal_value
      t.datetime  :date_time_value
      t.integer   :option_value
      t.timestamps null: false
    end

    add_index     :field_values, :issue_id
    add_index     :field_values, [:issue_id, :field_id]

    add_foreign_key :field_values, :issues
    add_foreign_key :field_values, :fields
    add_foreign_key :field_values, :options, column: :option_value
  end

  def down
    remove_foreign_key :field_values, column: :option_value
    remove_foreign_key :field_values, :fields
    remove_foreign_key :field_values, :issues

    remove_index  :field_values, [:issue_id, :field_id]
    remove_index  :field_values, :issue_id
    drop_table    :field_values
  end
end
