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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130530033537) do

  create_table "answers", :force => true do |t|
    t.string   "content",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "question_id",  :null => false
    t.integer  "index_number", :null => false
  end

  create_table "attempts", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "quiz_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "graded",     :default => false
    t.integer  "score",      :default => 0
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.string   "content",          :null => false
    t.integer  "user_id",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "components", :force => true do |t|
    t.integer  "component_index", :null => false
    t.integer  "unit_id",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "components_lectures", :force => true do |t|
    t.integer "component_id"
    t.integer "lecture_id"
  end

  create_table "components_quizzes", :force => true do |t|
    t.integer "component_id"
    t.integer "quiz_id"
  end

  create_table "gradebooks", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lecture_questions", :force => true do |t|
    t.integer  "lecture_id",  :null => false
    t.string   "content",     :null => false
    t.integer  "order_index", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "lectures", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "subtitle"
  end

  create_table "questions", :force => true do |t|
    t.string   "content",           :null => false
    t.integer  "correct_answer_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "name"
    t.integer  "points",            :null => false
    t.integer  "sort_number"
  end

  create_table "questions_quizzes", :force => true do |t|
    t.integer "question_id"
    t.integer "quiz_id"
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "duration"
    t.datetime "release_date",                    :null => false
    t.datetime "close_date"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "name",                            :null => false
    t.boolean  "autograde",    :default => false
  end

  create_table "responses", :force => true do |t|
    t.string   "content"
    t.integer  "answer_id"
    t.integer  "user_id",     :null => false
    t.integer  "question_id", :null => false
    t.integer  "attempt_id",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "points"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "units", :force => true do |t|
    t.datetime "release_date"
    t.datetime "close_date"
    t.string   "name",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
