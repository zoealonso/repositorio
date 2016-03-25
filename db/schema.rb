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

ActiveRecord::Schema.define(version: 20151127100831) do

  create_table "juegos", force: :cascade do |t|
    t.string  "nombre",    limit: 255
    t.integer "jugadores", limit: 4
  end

  add_index "juegos", ["jugadores"], name: "index_juegos_on_jugadores", using: :btree
  add_index "juegos", ["nombre"], name: "index_juegos_on_nombre", unique: true, using: :btree

  create_table "niveles", force: :cascade do |t|
    t.integer "numero",        limit: 4
    t.integer "puntos",        limit: 4
    t.integer "puntuacion_id", limit: 4
  end

  add_index "niveles", ["puntuacion_id"], name: "index_niveles_on_puntuacion_id", using: :btree

  create_table "puntuaciones", force: :cascade do |t|
    t.string  "puntos",     limit: 255
    t.integer "usuario_id", limit: 4
    t.integer "juego_id",   limit: 4
  end

  add_index "puntuaciones", ["juego_id"], name: "index_puntuaciones_on_juego_id", using: :btree
  add_index "puntuaciones", ["usuario_id"], name: "index_puntuaciones_on_usuario_id", using: :btree

  create_table "token_accesos", force: :cascade do |t|
    t.string  "token",      limit: 255
    t.integer "usuario_id", limit: 4
    t.integer "juego_id",   limit: 4
  end

  add_index "token_accesos", ["juego_id"], name: "index_token_accesos_on_juego_id", using: :btree
  add_index "token_accesos", ["usuario_id"], name: "index_token_accesos_on_usuario_id", using: :btree

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "nombre",                 limit: 255
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["nombre"], name: "index_usuarios_on_nombre", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "niveles", "puntuaciones"
  add_foreign_key "puntuaciones", "juegos"
  add_foreign_key "puntuaciones", "usuarios"
  add_foreign_key "token_accesos", "juegos"
  add_foreign_key "token_accesos", "usuarios"
end
