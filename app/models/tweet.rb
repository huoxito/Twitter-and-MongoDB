class Tweet
  include MongoMapper::Document
  validates_presence_of :from_user, :text, :from_user_id
end
