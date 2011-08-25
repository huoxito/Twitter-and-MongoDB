class Tweet
  include MongoMapper::Document
  
  key :autor, String
  key :texto, String
  key :tweet_id, String
  key :autor_id, String

  validates_presence_of :autor, :texto, :tweet_id, :autor_id

end
