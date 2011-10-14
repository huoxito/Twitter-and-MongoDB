class Search
  include MongoMapper::Document
  
  key :query, String
  key :times, Integer
  timestamps!
end
