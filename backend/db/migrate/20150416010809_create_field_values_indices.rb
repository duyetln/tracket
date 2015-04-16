class CreateFieldValuesIndices < ActiveRecord::Migration
  def up
    add_index :field_values, [:field_id, :string_value]
    add_index :field_values, [:field_id, :integer_value]
    add_index :field_values, [:field_id, :decimal_value]
    add_index :field_values, [:field_id, :date_time_value]
    add_index :field_values, [:field_id, :option_value]
  end

  def down
    remove_index :field_values, [:field_id, :option_value]
    remove_index :field_values, [:field_id, :date_time_value]
    remove_index :field_values, [:field_id, :decimal_value]
    remove_index :field_values, [:field_id, :integer_value]
    remove_index :field_values, [:field_id, :string_value]
  end
end
