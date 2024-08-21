# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_20_181644) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.bigint "service_id"
    t.string "name"
    t.string "budget_url"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_budgets_on_service_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "service_id"
    t.string "name"
    t.decimal "value"
    t.string "type"
    t.integer "total_payments"
    t.integer "payments"
    t.string "nota_fiscal_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_expenses_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "cost"
    t.decimal "gross_margin"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "budgets", "services"
  add_foreign_key "expenses", "services"
end
