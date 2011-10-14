class Search
  include MongoMapper::Document
  
  key :query, String, unique: true, required: true
  key :times, Integer
  timestamps!
end
