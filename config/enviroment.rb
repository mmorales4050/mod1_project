require "bundler"
Bundler.require 
ActiveRecord::Base.establish_connection(adaptor: "sqlite3", database: "db/development.db"
ActiveRecord::Base.logger = nil 
require_all "lib"
