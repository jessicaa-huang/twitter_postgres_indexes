SELECT count(*)
FROM tweets_mat
WHERE to_tsvector('english', text) @@ to_tsquery('english', 'coronavirus')
AND lang = 'en';
