SELECT count(*) FROM (
    SELECT DISTINCT data->>'id'
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'
    UNION
    SELECT DISTINCT data->>'id'
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'
) t;
