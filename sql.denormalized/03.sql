SELECT
    lang,
    count(DISTINCT id) AS count
FROM (
    SELECT data->>'lang' AS lang, data->>'id' AS id
    FROM tweets_jsonb
    WHERE data->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'
    UNION
    SELECT data->>'lang' AS lang, data->>'id' AS id
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags' @> '[{"text":"coronavirus"}]'
) t
GROUP BY lang
ORDER BY count DESC, lang;
