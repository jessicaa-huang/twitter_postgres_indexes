CREATE INDEX ON tweets_jsonb USING gin((data->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb USING gin((data->'extended_tweet'->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb((data->>'lang'));
CREATE INDEX gin_denorm_text ON tweets_jsonb USING gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));

CREATE MATERIALIZED VIEW tweets_mat AS (
    SELECT data->>'id' AS id_tweets, data->>'lang' AS lang, COALESCE(data->'extended_tweet'->>'full_text', data->>'text') AS text FROM tweets_jsonb
);
CREATE INDEX ON tweets_mat(id_tweets);
CREATE INDEX ON tweets_mat(lang);
CREATE INDEX ON tweets_mat USING gin(to_tsvector('english', text));

CREATE MATERIALIZED VIEW tweet_tags_mat AS (
    SELECT DISTINCT id_tweets, '#' || (jsonb->>'text') AS tag FROM (SELECT data->>'id' AS id_tweets, jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]') || COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')) AS jsonb FROM tweets_jsonb) t
);
CREATE INDEX ON tweet_tags_mat(tag);
CREATE INDEX ON tweet_tags_mat(id_tweets);
