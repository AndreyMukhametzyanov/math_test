# frozen_string_literal: true

require 'sqlite3'

db = SQLite3::Database.open('secret_users.db')
db.execute 'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY,name TEXT, age TEXT NOT NULL,statistic TEXT NOT NULL)'
db.close
