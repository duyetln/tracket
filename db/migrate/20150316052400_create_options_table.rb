class CreateOptionsTable < ActiveRecord::Migration
  def up
    create_table  :options do |t|
      t.integer   :option_field_id, null: false
      t.string    :name, null: false
      t.timestamps null: false
    end

    add_index :options, :option_field_id

    add_foreign_key :options, :fields, column: :option_field_id
  end

  def down
    remove_foreign_key :options, column: :option_field_id

    remove_index  :options, :option_field_id
    drop_table    :options
  end
end
