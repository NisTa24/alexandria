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

ActiveRecord::Schema[7.2].define(version: 2024_11_16_214902) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "token_digest"
    t.bigint "user_id", null: false
    t.bigint "api_key_id", null: false
    t.datetime "accessed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key_id"], name: "index_access_tokens_on_api_key_id"
    t.index ["user_id", "api_key_id"], name: "index_access_tokens_on_user_id_and_api_key_id", unique: true
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.string "key"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_api_keys_on_key", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "given_name"
    t.string "family_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.text "subtitle"
    t.string "isbn_10"
    t.string "isbn_13"
    t.text "description"
    t.date "released_on"
    t.bigint "publisher_id"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.text "download_url"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["isbn_10"], name: "index_books_on_isbn_10", unique: true
    t.index ["isbn_13"], name: "index_books_on_isbn_13", unique: true
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["title"], name: "index_books_on_title"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "user_id"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.string "idempotency_key"
    t.integer "status", default: 0
    t.string "charge_id"
    t.string "token"
    t.text "error", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_purchases_on_book_id"
    t.index ["user_id", "book_id"], name: "index_purchases_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "given_name"
    t.string "family_name"
    t.datetime "last_logged_in_at", precision: nil
    t.string "confirmation_token"
    t.text "confirmation_redirect_url"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "reset_password_token"
    t.text "reset_password_redirect_url"
    t.datetime "reset_password_sent_at", precision: nil
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access_tokens", "api_keys"
  add_foreign_key "access_tokens", "users"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "publishers"
  add_foreign_key "purchases", "books"
  add_foreign_key "purchases", "users"
end
