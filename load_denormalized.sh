#!/bin/bash
file=$1
unzip -p $file | sed 's/\\u0000//g' | psql postgresql://postgres:pass@localhost:2621/postgres -c "\COPY tweets_jsonb (data) FROM STDIN CSV QUOTE e'\x01' DELIMITER e'\x02'"
