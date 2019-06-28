#!/bin/sh
set -e
set -x

bin/extract-pbp
bin/extract-games
bin/extract-rosters > roster.csv
bin/extract-teams > team.csv

mysql < sql/create.sql
mysql < sql/load.sql

bin/extract-hitting > hitting.csv
bin/extract-pitching > pitching.csv
bin/extract-team-hitting > team-hitting.csv
bin/extract-bullpen > bullpen.csv

mysql < sql/load-streaker.sql
