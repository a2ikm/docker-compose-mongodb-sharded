#!/usr/bin/env ruby

require "bundler"
Bundler.require(:default)

MongoMapper.setup({"development" => {"uri" => ENV["MONGODB_URL"]}}, "development")

class Doc
  include MongoMapper::Document

  key :name, String
end

Doc.new.save!
