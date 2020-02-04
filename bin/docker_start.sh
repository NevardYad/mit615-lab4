#!/bin/bash

#Author:Draven Day
set +e
echo "=~=~=~=~=~=~= Attempting to migrate the DB =~=~=~=~=~=~="
bin/rails db:migrate 2>/dev/null
RET=$?
set -e
if [ $RET -gt 0 ]; then
    echo "=~=~=~=~=~=~= Migration Failed; Creating the DB =~=~=~=~=~=~="
    bin/rails db:create
    echo "=~=~=~=~=~=~= Migrating the DB =~=~=~=~=~=~="
    bin/rails db:migrate
    bin/rails db:test:prepare
    echo "=~=~=~=~=~=~= Seeding the DB =~=~=~=~=~=~="
    bin/rails db:seed
fi
echo "=~=~=~=~=~=~= Removing Old server PID =~=~=~=~=~=~="
rm -f tmp/pids/server.pid
echo "=~=~=~=~=~=~= Starting the WebServer =~=~=~=~=~=~="
bin/rails server -p 3000 -b '0.0.0.0'