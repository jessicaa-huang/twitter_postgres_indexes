WITH matched AS MATERIALIZED (
    SELECT id_tweets
    FROM tweets_mat
    WHERE to_tsvector('english', text) @@ to_tsquery('english', 'coronavirus')
    AND lang = 'en'
)
SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT m.id_tweets, tag
    FROM matched m
    JOIN tweet_tags_mat USING (id_tweets)
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
