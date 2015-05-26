# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150406020426) do

  create_table "clauses", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4
    t.string   "type",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "clauses", ["parent_id"], name: "index_clauses_on_parent_id", using: :btree

  create_table "conditions", force: :cascade do |t|
    t.integer  "clause_id",       limit: 4
    t.integer  "field_id",        limit: 4,                                    null: false
    t.string   "type",            limit: 255,                                  null: false
    t.boolean  "inversed",        limit: 1,                    default: false
    t.string   "string_value",    limit: 255
    t.text     "text_value",      limit: 65535
    t.integer  "integer_value",   limit: 4
    t.decimal  "decimal_value",                 precision: 10
    t.datetime "date_time_value"
    t.integer  "option_value",    limit: 4
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  add_index "conditions", ["clause_id"], name: "index_conditions_on_clause_id", using: :btree
  add_index "conditions", ["field_id"], name: "fk_rails_54e0af363f", using: :btree
  add_index "conditions", ["option_value"], name: "fk_rails_f1f8d3696a", using: :btree

  create_table "field_values", force: :cascade do |t|
    t.integer  "issue_id",        limit: 4,                    null: false
    t.integer  "field_id",        limit: 4,                    null: false
    t.string   "string_value",    limit: 255
    t.text     "text_value",      limit: 65535
    t.integer  "integer_value",   limit: 4
    t.decimal  "decimal_value",                 precision: 10
    t.datetime "date_time_value"
    t.integer  "option_value",    limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "field_values", ["field_id"], name: "fk_rails_dad590565f", using: :btree
  add_index "field_values", ["issue_id", "field_id"], name: "index_field_values_on_issue_id_and_field_id", using: :btree
  add_index "field_values", ["issue_id"], name: "index_field_values_on_issue_id", using: :btree
  add_index "field_values", ["option_value"], name: "fk_rails_52bf82ddfd", using: :btree

  create_table "fields", force: :cascade do |t|
    t.integer  "project_id", limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.string   "type",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "fields", ["project_id"], name: "index_fields_on_project_id", using: :btree

  create_table "issues", force: :cascade do |t|
    t.integer  "project_id",  limit: 4,     null: false
    t.integer  "number",      limit: 4,     null: false
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "issues", ["number"], name: "index_issues_on_number", using: :btree
  add_index "issues", ["project_id"], name: "fk_rails_ebab7b4e57", using: :btree

  create_table "options", force: :cascade do |t|
    t.integer  "option_field_id", limit: 4,   null: false
    t.string   "name",            limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "options", ["option_field_id"], name: "index_options_on_option_field_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "clauses", "clauses", column: "parent_id"
  add_foreign_key "conditions", "clauses"
  add_foreign_key "conditions", "fields"
  add_foreign_key "conditions", "options", column: "option_value"
  add_foreign_key "field_values", "fields"
  add_foreign_key "field_values", "issues"
  add_foreign_key "field_values", "options", column: "option_value"
  add_foreign_key "fields", "projects"
  add_foreign_key "issues", "projects"
  add_foreign_key "options", "fields", column: "option_field_id"
end
