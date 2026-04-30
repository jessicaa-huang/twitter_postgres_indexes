CREATE INDEX ON tweet_tags(tag, id_tweets);
CREATE INDEX ON tweets(lang);
CREATE INDEX ON tweets(id_tweets);
CREATE INDEX gin_tweets_text ON tweets USING gin(to_tsvector('english', text));
