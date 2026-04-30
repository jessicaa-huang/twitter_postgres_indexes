SELECT
    tag,
    count(*) AS count
FROM (
    SELECT DISTINCT id_tweets, tag FROM (
        SELECT DISTINCT
            data->>'id' AS id_tweets,
            '#' || (jsonb->>'text') AS tag
        FROM tweets_jsonb,
        jsonb_array_elements(COALESCE(data->'entities'->'hashtags','[]')) AS jsonb
        WHERE data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'
        UNION
        SELECT DISTINCT
            data->>'id' AS id_tweets,
            '#' || (jsonb->>'text') AS tag
        FROM tweets_jsonb,
        jsonb_array_elements(COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]')) AS jsonb
        WHERE data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'
    ) t
    WHERE tag LIKE '#%'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;
