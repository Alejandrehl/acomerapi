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

ActiveRecord::Schema.define(version: 2019_08_05_224753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_branch_leaders", force: :cascade do |t|
    t.integer "id_admin"
    t.integer "id_leader"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_admin_branch_leaders_on_branch_id"
  end

  create_table "admin_cook_accounts", force: :cascade do |t|
    t.integer "id_admin"
    t.integer "id_cook"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_admin_cook_accounts_on_branch_id"
  end

  create_table "admin_waiter_accounts", force: :cascade do |t|
    t.integer "id_admin"
    t.integer "id_waiter"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_admin_waiter_accounts_on_branch_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "business_name"
    t.integer "business_rut"
    t.string "business_email"
    t.string "bank_name"
    t.string "account_type"
    t.bigint "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_bank_accounts_on_restaurant_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "street"
    t.string "email_manager"
    t.string "telephone_manager"
    t.text "information"
    t.string "hour_op"
    t.string "hour_cl"
    t.string "instagram_id"
    t.string "instagram_api_token"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "branch_category"
    t.float "lat"
    t.float "leng"
    t.string "by_tables"
    t.string "step"
    t.index ["restaurant_id"], name: "index_branches_on_restaurant_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "img_url"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "categories_menus", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categories_menus_on_category_id"
    t.index ["menu_id"], name: "index_categories_menus_on_menu_id"
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "product_id", null: false
    t.index ["category_id"], name: "index_categories_products_on_category_id"
    t.index ["product_id"], name: "index_categories_products_on_product_id"
  end

  create_table "featured_branches", force: :cascade do |t|
    t.bigint "branch_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_featured_branches_on_branch_id"
  end

  create_table "image_path_categories", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_image_path_categories_on_category_id"
  end

  create_table "image_paths", force: :cascade do |t|
    t.bigint "branch_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_image_paths_on_branch_id"
  end

  create_table "image_product_paths", force: :cascade do |t|
    t.bigint "product_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_image_product_paths_on_product_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "categories_id"
    t.string "img_url"
    t.index ["branch_id"], name: "index_menus_on_branch_id"
    t.index ["categories_id"], name: "index_menus_on_categories_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "order_id"
    t.bigint "product_id"
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total"
    t.string "status"
    t.text "specification"
    t.string "reservation"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "payment_method"
    t.boolean "payed"
    t.bigint "tables_id"
    t.bigint "branch_id"
    t.string "transaction_id"
    t.string "payment_modality"
    t.index ["branch_id"], name: "index_orders_on_branch_id"
    t.index ["tables_id"], name: "index_orders_on_tables_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_products", id: false, force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.index ["order_id", "product_id"], name: "index_orders_products_on_order_id_and_product_id"
    t.index ["order_id"], name: "index_orders_products_on_order_id"
    t.index ["product_id"], name: "index_orders_products_on_product_id"
  end

  create_table "post_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "author"
    t.text "image"
    t.integer "likes"
    t.bigint "user_id"
    t.bigint "post_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_category_id"], name: "index_posts_on_post_category_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.integer "cost"
    t.string "ingredient"
    t.integer "calories"
    t.integer "proteins"
    t.integer "carbohydrates"
    t.integer "saturated_fats"
    t.integer "unsaturated_fats"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.boolean "specialty"
    t.boolean "activated"
    t.integer "value_offer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "offer_activated", default: false
    t.integer "waiting_time"
    t.string "img_url"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "reserves", force: :cascade do |t|
    t.datetime "reservation_day"
    t.integer "number_people"
    t.bigint "user_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "reservation_hour"
    t.string "mode"
    t.index ["order_id"], name: "index_reserves_on_order_id"
    t.index ["user_id"], name: "index_reserves_on_user_id"
  end

  create_table "restaurant_reviews", force: :cascade do |t|
    t.string "title"
    t.text "review"
    t.integer "stars"
    t.bigint "restaurant_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_restaurant_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_restaurant_reviews_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "business_name"
    t.string "giro"
    t.string "telephone"
    t.string "email"
    t.text "instagram"
    t.text "facebook"
    t.text "twitter"
    t.text "pinterest"
    t.text "tripadvisor"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "address"
    t.string "city"
    t.integer "rating", default: 0
    t.integer "rating_total", default: 0
    t.integer "quantity_voting", default: 0
    t.string "status", default: "pending"
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "stars"
    t.string "commentary"
    t.bigint "user_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "day"
    t.time "opening"
    t.time "closing"
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_schedules_on_branch_id"
  end

  create_table "tables", force: :cascade do |t|
    t.string "description"
    t.string "state"
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.boolean "assign", default: false
    t.index ["branch_id"], name: "index_tables_on_branch_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "last_name"
    t.string "phone"
    t.string "rut"
    t.date "birthdate"
    t.string "gender"
    t.string "provider"
    t.string "uid"
    t.text "image"
    t.string "biography"
    t.string "linkedin"
    t.string "twitter"
    t.string "web"
    t.string "instagram"
    t.string "exp"
    t.boolean "admin"
    t.integer "branch_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "waiter_calls", force: :cascade do |t|
    t.bigint "table_id"
    t.index ["table_id"], name: "index_waiter_calls_on_table_id"
  end

  create_table "waiter_states", force: :cascade do |t|
    t.string "reason"
    t.bigint "table_id"
    t.index ["table_id"], name: "index_waiter_states_on_table_id"
  end

  create_table "waiter_tables", force: :cascade do |t|
    t.bigint "table_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_waiter_tables_on_table_id"
    t.index ["user_id"], name: "index_waiter_tables_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_branch_leaders", "branches"
  add_foreign_key "admin_cook_accounts", "branches"
  add_foreign_key "admin_waiter_accounts", "branches"
  add_foreign_key "bank_accounts", "restaurants"
  add_foreign_key "branches", "restaurants"
  add_foreign_key "categories", "users"
  add_foreign_key "categories_menus", "categories"
  add_foreign_key "categories_menus", "menus"
  add_foreign_key "featured_branches", "branches"
  add_foreign_key "image_path_categories", "categories"
  add_foreign_key "image_paths", "branches"
  add_foreign_key "image_product_paths", "products"
  add_foreign_key "menus", "branches"
  add_foreign_key "menus", "categories", column: "categories_id"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "branches"
  add_foreign_key "orders", "users"
  add_foreign_key "posts", "post_categories"
  add_foreign_key "posts", "users"
  add_foreign_key "products", "users"
  add_foreign_key "reserves", "orders"
  add_foreign_key "reserves", "users"
  add_foreign_key "restaurant_reviews", "restaurants"
  add_foreign_key "restaurant_reviews", "users"
  add_foreign_key "restaurants", "users"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
  add_foreign_key "schedules", "branches"
  add_foreign_key "tables", "branches"
  add_foreign_key "waiter_calls", "tables"
  add_foreign_key "waiter_states", "tables"
  add_foreign_key "waiter_tables", "tables"
  add_foreign_key "waiter_tables", "users"
end
