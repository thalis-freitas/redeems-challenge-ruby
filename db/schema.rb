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

ActiveRecord::Schema[7.1].define(version: 2024_11_09_134241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street", null: false
    t.string "number", null: false
    t.string "complement"
    t.string "neighborhood", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "redeem_id", null: false
    t.bigint "question_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["redeem_id"], name: "index_answers_on_redeem_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "redeem_page_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["redeem_page_id"], name: "index_questions_on_redeem_page_id"
  end

  create_table "redeem_page_size_options", force: :cascade do |t|
    t.bigint "redeem_page_id", null: false
    t.bigint "size_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["redeem_page_id", "size_option_id"], name: "idx_on_redeem_page_id_size_option_id_748055fd9b", unique: true
    t.index ["redeem_page_id"], name: "index_redeem_page_size_options_on_redeem_page_id"
    t.index ["size_option_id"], name: "index_redeem_page_size_options_on_size_option_id"
  end

  create_table "redeem_pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
  end

  create_table "redeems", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "redeem_page_id", null: false
    t.bigint "address_id", null: false
    t.integer "status", default: 0, null: false
    t.bigint "size_option_id"
    t.index ["address_id"], name: "index_redeems_on_address_id"
    t.index ["redeem_page_id"], name: "index_redeems_on_redeem_page_id"
    t.index ["size_option_id"], name: "index_redeems_on_size_option_id"
    t.index ["user_id"], name: "index_redeems_on_user_id"
  end

  create_table "size_options", force: :cascade do |t|
    t.integer "size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "registration_number", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["registration_number"], name: "index_users_on_registration_number", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "redeems"
  add_foreign_key "questions", "redeem_pages"
  add_foreign_key "redeem_page_size_options", "redeem_pages"
  add_foreign_key "redeem_page_size_options", "size_options"
  add_foreign_key "redeems", "addresses"
  add_foreign_key "redeems", "redeem_pages"
  add_foreign_key "redeems", "size_options"
  add_foreign_key "redeems", "users"
end
