#!/bin/bash

set -e

if [ "$ENV" = 'dev' ]; then
    echo "Running Development Server"
    exec python "identidock.py"
elif [ "$ENV" == 'unit' ]; then
    echo "Running Unit Test"
    exec python "tests.py"
else
    exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
               --callable app --stats 0.0.0.0:9191
fi