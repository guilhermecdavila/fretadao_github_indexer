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

ActiveRecord::Schema[7.2].define(version: 2025_08_31_225212) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "github_users", force: :cascade do |t|
    t.string "name"
    t.string "github_url"
    t.string "nickname"
    t.string "image_url"
    t.string "contribution"
    t.string "followers"
    t.string "following"
    t.string "stars"
    t.string "organization"
    t.string "location"
    t.string "encripted_github_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_url"], name: "index_github_users_on_github_url"
    t.index ["location"], name: "index_github_users_on_location"
    t.index ["name"], name: "index_github_users_on_name"
    t.index ["nickname"], name: "index_github_users_on_nickname"
    t.index ["organization"], name: "index_github_users_on_organization"
  end
end
