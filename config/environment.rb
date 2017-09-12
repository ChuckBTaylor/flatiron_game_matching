require 'bundler/setup'
Bundler.require


require 'pry'
require 'active_record'
require 'rake'
require 'yaml/store'
require 'ostruct'
require 'date'
require_relative "../classes/user.rb"
require_relative "../classes/game.rb"
require_relative "../classes/gaming_queue.rb"
require_relative "../functions/functions.rb"
require_relative "../classes/session_manager.rb"
require_relative "../classes/session.rb"


DB = ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/gaming.sqlite"
)

ActiveRecord::Base.logger = false
