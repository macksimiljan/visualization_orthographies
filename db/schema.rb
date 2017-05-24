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

ActiveRecord::Schema.define(version: 20170519155431) do

  create_table "coptic_sublemmas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "label"
    t.string   "pos"
    t.integer  "greek_lemma_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["greek_lemma_id"], name: "index_coptic_sublemmas_on_greek_lemma_id", using: :btree
  end

  create_table "greek_lemmas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "label"
    t.string   "meaning"
    t.string   "pos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orthographies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "label"
    t.integer  "coptic_sublemma_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["coptic_sublemma_id"], name: "index_orthographies_on_coptic_sublemma_id", using: :btree
  end

  create_table "sources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dating_start"
    t.integer  "dating_end"
    t.string   "dialect"
    t.string   "manuscript"
    t.string   "text"
    t.string   "typo_broad"
    t.string   "typo_sociohistoric"
    t.string   "typo_form"
    t.string   "typo_content"
    t.string   "typo_subjectmatter"
    t.string   "typo_speccorpus"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["dating_end"], name: "index_sources_on_dating_end", using: :btree
    t.index ["dating_start"], name: "index_sources_on_dating_start", using: :btree
    t.index ["dialect"], name: "index_sources_on_dialect", using: :btree
  end

  add_foreign_key "coptic_sublemmas", "greek_lemmas"
  add_foreign_key "orthographies", "coptic_sublemmas"
end
