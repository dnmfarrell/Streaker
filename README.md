Streaker
--------
Beat the Streak™ is free MLB [game](https://www.mlb.com/apps/beat-the-streak)
in which the goal is to pick a batter to get a hit in their next game,
correctly 57 times in a row. In the 18 years it has been running, no one has
beaten the streak.

This project aggregates MLB data into a MySQL database for input into machine
learning tools.

N.B. the aggregated data is work-in-progress, this is an early version.

Dependencies
------------
This project uses Retrosheet play by play
[data](https://www.retrosheet.org/game.htm).

The Chadwick
[tools](https://github.com/chadwickbureau/chadwick/releases) are used to parse
the data.

The data is aggregated in a local MySQL server database, you'll need it
listening on localhost with a ~/.my.cnf file configured with a user and
password and permission to create databases.

Installation
------------
This setup is a bit janky, maybe I'll create a makefile at somepoint.

1. Clone this repo
2. Set the `STREAKER_USER` and `STREAKER_PASS` env variables with your MySQL creds
3. Download and unzip the retrosheet pbp data you want to include into the
   project root
4. Run `install.sh`, this will create the streaker database on MySQL server
5. The streaker.streaker table contains the aggregated data, you can unload it
 into training, validation and testing csvs with `sql/unload-data.sql`:

    $ mysql < sql/unload-data.sql

6. Feed the csvs created under /tmp into your favorite ML tool!


Copyright (c) 2019 David Farrell

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
