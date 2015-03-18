class CreateOptionsTable < ActiveRecord::Migration
  def up
    create_table  :options do |t|
      t.integer   :field_id, null: false
      t.string    :name, null: false
      t.timestamps null: false
    end

    add_index     :options, :field_id

    add_foreign_key :options, :fields
  end

  def down
    remove_foreign_key :options, :fields

    remove_index  :options, :field_id
    drop_table    :options
  end
end
