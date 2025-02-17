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

ActiveRecord::Schema[7.1].define(version: 2025_01_27_232502) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrator_company_invites", force: :cascade do |t|
    t.bigint "administrator_id", null: false
    t.bigint "company_id", null: false
    t.bigint "invite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrator_id", "company_id", "invite_id"], name: "index_admin_company_invites_on_admin_company_invite"
    t.index ["administrator_id"], name: "index_administrator_company_invites_on_administrator_id"
    t.index ["company_id"], name: "index_administrator_company_invites_on_company_id"
    t.index ["invite_id"], name: "index_administrator_company_invites_on_invite_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_invites", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "invite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "invite_id"], name: "index_company_invites_on_company_invite"
    t.index ["company_id"], name: "index_company_invites_on_company_id"
    t.index ["invite_id"], name: "index_company_invites_on_invite_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_completion"
  end

  add_foreign_key "administrator_company_invites", "administrators"
  add_foreign_key "administrator_company_invites", "companies"
  add_foreign_key "administrator_company_invites", "invites"
  add_foreign_key "company_invites", "companies"
  add_foreign_key "company_invites", "invites"
end
