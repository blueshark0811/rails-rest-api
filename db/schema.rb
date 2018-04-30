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

ActiveRecord::Schema.define(version: 20180430063621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "activities", force: :cascade do |t|
    t.string "eventable_type"
    t.bigint "eventable_id"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.jsonb "message", default: {}, null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "task_id"
    t.bigint "lesson_id"
    t.bigint "course_id"
    t.bigint "group_id"
    t.bigint "organization_id"
    t.bigint "user_id"
    t.boolean "flagged", default: false
    t.index ["course_id"], name: "index_activities_on_course_id"
    t.index ["eventable_type", "eventable_id"], name: "index_activities_on_eventable_type_and_eventable_id"
    t.index ["group_id"], name: "index_activities_on_group_id"
    t.index ["lesson_id"], name: "index_activities_on_lesson_id"
    t.index ["notifiable_type", "notifiable_id"], name: "index_activities_on_notifiable_type_and_notifiable_id"
    t.index ["organization_id"], name: "index_activities_on_organization_id"
    t.index ["task_id"], name: "index_activities_on_task_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "addon_courses", force: :cascade do |t|
    t.bigint "addon_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addon_id"], name: "index_addon_courses_on_addon_id"
    t.index ["course_id"], name: "index_addon_courses_on_course_id"
  end

  create_table "addon_organizations", force: :cascade do |t|
    t.bigint "addon_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addon_id"], name: "index_addon_organizations_on_addon_id"
    t.index ["organization_id"], name: "index_addon_organizations_on_organization_id"
  end

  create_table "addons", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "data"
    t.bigint "user_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachmentable_type"
    t.bigint "attachmentable_id"
    t.index ["attachmentable_type", "attachmentable_id"], name: "index_attachments_on_attachmentable_type_and_attachmentable_id"
    t.index ["organization_id"], name: "index_attachments_on_organization_id"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chat_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "chat_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chat_users_on_chat_id"
    t.index ["user_id"], name: "index_chat_users_on_user_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_chats_on_organization_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.integer "user_id", null: false
    t.integer "root_id"
    t.integer "main_root_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tree_path", default: [], array: true
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "phonecode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_groups", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "group_id"
    t.bigint "precourse_id"
    t.string "complete_lesson_can"
    t.boolean "reports_enabled"
    t.boolean "files_enabled"
    t.boolean "discussing_enabled"
    t.boolean "student_content_enabled"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_groups_on_course_id"
    t.index ["group_id"], name: "index_course_groups_on_group_id"
    t.index ["precourse_id"], name: "index_course_groups_on_precourse_id"
  end

  create_table "course_threads", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.integer "comments_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_activity_at"
    t.bigint "course_group_id"
    t.index ["course_group_id"], name: "index_course_threads_on_course_group_id"
    t.index ["user_id"], name: "index_course_threads_on_user_id"
  end

  create_table "course_users", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_group_id"
    t.integer "position", default: 0
    t.index ["course_group_id"], name: "index_course_users_on_course_group_id"
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.bigint "user_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lessons_count", default: 0
    t.index ["organization_id"], name: "index_courses_on_organization_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "title"
    t.text "description"
    t.string "status"
    t.integer "user_limit"
    t.string "visibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count_participants"
    t.bigint "user_id"
    t.jsonb "noticeboard_settings", default: {}, null: false
    t.index ["organization_id"], name: "index_groups_on_organization_id"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "lesson_users", force: :cascade do |t|
    t.bigint "lesson_id"
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_group_id"
    t.index ["course_group_id"], name: "index_lesson_users_on_course_group_id"
    t.index ["lesson_id"], name: "index_lesson_users_on_lesson_id"
    t.index ["user_id"], name: "index_lesson_users_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "organization_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.text "exclude_students_ids"
    t.boolean "files_controll_enabled"
    t.boolean "messanger_access_enabled"
    t.jsonb "activity_settings", default: {"activity_course_ids"=>[], "activity_student_ids"=>[]}
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "title"
    t.string "subdomain"
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "logo"
    t.string "address"
    t.string "zip_code"
    t.string "website"
    t.string "email"
    t.string "phone"
    t.string "language"
    t.jsonb "notification_settings", default: {"notification_email"=>nil}
    t.jsonb "display_settings", default: {"display_name"=>nil, "display_type"=>"display_name"}
    t.bigint "country_id"
    t.bigint "state_id"
    t.index ["country_id"], name: "index_organizations_on_country_id"
    t.index ["state_id"], name: "index_organizations_on_state_id"
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text "database"
    t.text "user"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.bigint "calls"
    t.datetime "captured_at"
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "task_users", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "user_id"
    t.bigint "course_group_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_group_id"], name: "index_task_users_on_course_group_id"
    t.index ["task_id"], name: "index_task_users_on_task_id"
    t.index ["user_id"], name: "index_task_users_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "action_type"
    t.text "description"
    t.bigint "lesson_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_tasks_on_lesson_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "admin_role"
    t.string "phone_number"
    t.date "date_of_birth"
    t.string "address"
    t.bigint "country_id"
    t.bigint "state_id"
    t.string "zip_code"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["state_id"], name: "index_users_on_state_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.integer "length"
    t.string "sproutvideo_id"
    t.bigint "organization_id"
    t.bigint "user_id"
    t.string "videoable_type"
    t.bigint "videoable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_link"
    t.string "status"
    t.string "token"
    t.text "embed_code"
    t.index ["organization_id"], name: "index_videos_on_organization_id"
    t.index ["user_id"], name: "index_videos_on_user_id"
    t.index ["videoable_type", "videoable_id"], name: "index_videos_on_videoable_type_and_videoable_id"
  end

  add_foreign_key "activities", "courses"
  add_foreign_key "activities", "groups"
  add_foreign_key "activities", "lessons"
  add_foreign_key "activities", "organizations"
  add_foreign_key "activities", "tasks"
  add_foreign_key "activities", "users"
  add_foreign_key "addon_courses", "addons"
  add_foreign_key "addon_courses", "courses"
  add_foreign_key "addon_organizations", "addons"
  add_foreign_key "addon_organizations", "organizations"
  add_foreign_key "attachments", "organizations"
  add_foreign_key "attachments", "users"
  add_foreign_key "chat_messages", "chats"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "chat_users", "chats"
  add_foreign_key "chat_users", "users"
  add_foreign_key "chats", "organizations"
  add_foreign_key "cities", "states"
  add_foreign_key "course_groups", "courses"
  add_foreign_key "course_groups", "courses", column: "precourse_id"
  add_foreign_key "course_groups", "groups"
  add_foreign_key "course_threads", "users"
  add_foreign_key "course_users", "course_groups"
  add_foreign_key "course_users", "courses"
  add_foreign_key "course_users", "users"
  add_foreign_key "courses", "organizations"
  add_foreign_key "courses", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "groups", "organizations"
  add_foreign_key "groups", "users"
  add_foreign_key "lesson_users", "course_groups"
  add_foreign_key "lesson_users", "lessons"
  add_foreign_key "lesson_users", "users"
  add_foreign_key "lessons", "users"
  add_foreign_key "organization_users", "organizations"
  add_foreign_key "organization_users", "users"
  add_foreign_key "organizations", "countries"
  add_foreign_key "organizations", "states"
  add_foreign_key "states", "countries"
  add_foreign_key "task_users", "course_groups"
  add_foreign_key "task_users", "tasks"
  add_foreign_key "task_users", "users"
  add_foreign_key "tasks", "lessons"
  add_foreign_key "tasks", "users"
  add_foreign_key "videos", "organizations"
  add_foreign_key "videos", "users"
end
