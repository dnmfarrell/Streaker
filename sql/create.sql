create database streaker
;
use streaker
;
create table pbp (
pbp_id                    integer primary key auto_increment,
game_id                   char(12),
away_team_id              char(3),
inn_ct                    integer,
bat_home_id               integer,
outs_ct                   integer,
balls_ct                  integer,
strikes_ct                integer,
pitch_seq_tx              varchar(30),
away_score_ct             integer,
home_score_ct             integer,
bat_id                    char(8),
bat_hand_cd               char(1),
resp_bat_id               char(8),
resp_bat_hand_cd          char(1),
pit_id                    char(8),
pit_hand_cd               char(1),
resp_pit_id               char(8),
resp_pit_hand_cd          char(1),
pos2_fld_id               char(8),
pos3_fld_id               char(8),
pos4_fld_id               char(8),
pos5_fld_id               char(8),
pos6_fld_id               char(8),
pos7_fld_id               char(8),
pos8_fld_id               char(8),
pos9_fld_id               char(8),
base1_run_id              char(8),
base2_run_id              char(8),
base3_run_id              char(8),
event_tx                  varchar(54),
leadoff_fl                char(1),
ph_fl                     char(1),
bat_fld_cd                integer,
bat_lineup_id             integer,
event_cd                  integer,
bat_event_fl              char(1),
ab_fl                     char(1),
h_cd                      integer,
sh_fl                     char(1),
sf_fl                     char(1),
event_outs_ct             integer,
dp_fl                     char(1),
tp_fl                     char(1),
rbi_ct                    integer,
wp_fl                     char(1),
pb_fl                     char(1),
fld_cd                    integer,
battedball_cd             char(1),
bunt_fl                   char(1),
foul_fl                   char(1),
battedball_loc_tx         varchar(5),
err_ct                    integer,
err1_fld_cd               integer,
err1_cd                   char(1),
err2_fld_cd               integer,
err2_cd                   char(1),
err3_fld_cd               integer,
err3_cd                   char(1),
bat_dest_id               integer,
run1_dest_id              integer,
run2_dest_id              integer,
run3_dest_id              integer,
bat_play_tx               varchar(8),
run1_play_tx              varchar(10),
run2_play_tx              varchar(8),
run3_play_tx              varchar(8),
run1_sb_fl                char(1),
run2_sb_fl                char(1),
run3_sb_fl                char(1),
run1_cs_fl                char(1),
run2_cs_fl                char(1),
run3_cs_fl                char(1),
run1_pk_fl                char(1),
run2_pk_fl                char(1),
run3_pk_fl                char(1),
run1_resp_pit_id          char(8),
run2_resp_pit_id          char(8),
run3_resp_pit_id          char(8),
game_new_fl               char(1),
game_end_fl               char(1),
pr_run1_fl                char(1),
pr_run2_fl                char(1),
pr_run3_fl                char(1),
removed_for_pr_run1_id    char(8),
removed_for_pr_run2_id    char(8),
removed_for_pr_run3_id    char(8),
removed_for_ph_bat_id     char(8),
removed_for_ph_bat_fld_cd integer,
po1_fld_cd                integer,
po2_fld_cd                integer,
po3_fld_cd                integer,
ass1_fld_cd               integer,
ass2_fld_cd               integer,
ass3_fld_cd               integer,
ass4_fld_cd               integer,
ass5_fld_cd               integer,
event_id                  integer,
home_team_id              char(3),
bat_team_id               char(3),
fld_team_id               char(3),
bat_last_id               integer,
inn_new_fl                char(1),
inn_end_fl                char(1),
start_bat_score_ct        integer,
start_fld_score_ct        integer,
inn_runs_ct               integer,
game_pa_ct                integer,
inn_pa_ct                 integer,
pa_new_fl                 char(1),
pa_trunc_fl               char(1),
start_bases_cd            integer,
end_bases_cd              integer,
bat_start_fl              char(1),
resp_bat_start_fl         char(1),
bat_on_deck_id            char(8),
bat_in_hold_id            char(8),
pit_start_fl              char(1),
resp_pit_start_fl         char(1),
run1_fld_cd               integer,
run1_lineup_cd            integer,
run1_origin_event_id      integer,
run2_fld_cd               integer,
run2_lineup_cd            integer,
run2_origin_event_id      integer,
run3_fld_cd               integer,
run3_lineup_cd            integer,
run3_origin_event_id      integer,
run1_resp_cat_id          char(8),
run2_resp_cat_id          char(8),
run3_resp_cat_id          char(8),
pa_ball_ct                integer,
pa_called_ball_ct         integer,
pa_intent_ball_ct         integer,
pa_pitchout_ball_ct       integer,
pa_hitbatter_ball_ct      integer,
pa_other_ball_ct          integer,
pa_strike_ct              integer,
pa_called_strike_ct       integer,
pa_swingmiss_strike_ct    integer,
pa_foul_strike_ct         integer,
pa_inplay_strike_ct       integer,
pa_other_strike_ct        integer,
event_runs_ct             integer,
fld_id                    char(8),
base2_force_fl            char(1),
base3_force_fl            char(1),
base4_force_fl            char(1),
bat_safe_err_fl           char(1),
bat_fate_id               integer,
run1_fate_id              integer,
run2_fate_id              integer,
run3_fate_id              integer,
fate_runs_ct              integer,
ass6_fld_cd               integer,
ass7_fld_cd               integer,
ass8_fld_cd               integer,
ass9_fld_cd               integer,
ass10_fld_cd              integer)
;
create index game_id on pbp (game_id)
;
create table roster (
  player_id char(8),
  lastname varchar(14),
  firstname varchar(12),
  bats char(1),
  throws char(1),
  team_id char(3),
  position varchar(2),
  year integer
)
;
create index roster_team_year on roster (team_id, year)
;
create unique index roster_team_year_player on roster (player_id, team_id, year)
;
create table team (
  team_id char(3),
  league char(1),
  city varchar(13),
  name varchar(12),
  year integer
)
;
create unique index team_year on team (team_id, year)
;
create table game (
  game_id char(12),
  game_dt int,
  game_ct int,
  game_dy varchar(9),
  start_game_tm int,
  dh_fl char(1),
  daynight_park_cd char(1),
  away_team_id char(3),
  home_team_id char(3),
  park_id char(5),
  away_start_pit_id char(8),
  home_start_pit_id char(8),
  base4_ump_id char(8),
  base1_ump_id char(8),
  base2_ump_id char(8),
  base3_ump_id char(8),
  lf_ump_id char(8),
  rf_ump_id char(8),
  attend_park_ct int,
  scorer_record_id char(8),
  translator_record_id char(8),
  inputter_record_id char(8),
  input_record_ts char(8),
  edit_record_ts char(8),
  method_record_cd int,
  pitches_record_cd int,
  temp_park_ct int,
  wind_direction_park_cd int,
  wind_speed_park_ct int,
  field_park_cd int,
  precip_park_cd int,
  sky_park_cd int,
  minutes_game_ct int,
  inn_ct int,
  away_score_ct int,
  home_score_ct int,
  away_hits_ct int,
  home_hits_ct int,
  away_err_ct int,
  home_err_ct int,
  away_lob_ct int,
  home_lob_ct int,
  win_pit_id char(8),
  lose_pit_id char(8),
  save_pit_id char(8),
  gwrbi_bat_id char(8),
  away_lineup1_bat_id char(8),
  away_lineup1_fld_cd int,
  away_lineup2_bat_id char(8),
  away_lineup2_fld_cd int,
  away_lineup3_bat_id char(8),
  away_lineup3_fld_cd int,
  away_lineup4_bat_id char(8),
  away_lineup4_fld_cd int,
  away_lineup5_bat_id char(8),
  away_lineup5_fld_cd int,
  away_lineup6_bat_id char(8),
  away_lineup6_fld_cd int,
  away_lineup7_bat_id char(8),
  away_lineup7_fld_cd int,
  away_lineup8_bat_id char(8),
  away_lineup8_fld_cd int,
  away_lineup9_bat_id char(8),
  away_lineup9_fld_cd int,
  home_lineup1_bat_id char(8),
  home_lineup1_fld_cd int,
  home_lineup2_bat_id char(8),
  home_lineup2_fld_cd int,
  home_lineup3_bat_id char(8),
  home_lineup3_fld_cd int,
  home_lineup4_bat_id char(8),
  home_lineup4_fld_cd int,
  home_lineup5_bat_id char(8),
  home_lineup5_fld_cd int,
  home_lineup6_bat_id char(8),
  home_lineup6_fld_cd int,
  home_lineup7_bat_id char(8),
  home_lineup7_fld_cd int,
  home_lineup8_bat_id char(8),
  home_lineup8_fld_cd int,
  home_lineup9_bat_id char(8),
  home_lineup9_fld_cd int,
  away_finish_pit_id char(8),
  home_finish_pit_id char(8)
)
;

-- the at bat table lists every at bat for every game and whether there was a hit or not
create table ab (
  ab_id         int unsigned auto_increment primary key,
  game_id       char(12),
  bat_team_id   char(3),
  bat_lineup_id int,
  bat_id        char(8),
  bat_hand_cd   char(1),
  pit_team_id   char(3),
  pit_id        char(8),
  pit_hand_cd   char(1),
  hit_fl        int,
  slg_cd        int,
  ob_fl         int
)
;
create index ab_game_id on ab (game_id)
;

create table hitting (
  game_id       char(12),
  bat_team_id   char(3),
  bat_lineup_id int,
  bat_id        char(8),
  ab            int unsigned,
  h             int unsigned,
  ob            int unsigned,
  slg           decimal(5,3),
  hp            decimal(5,3),
  obp           decimal(5,3),
  h_last10      int unsigned
)
;
create index hitting_game_id on hitting (game_id)
;
create index hitting_team_id on hitting (bat_team_id)
;

create table team_hitting (
  game_id       char(12),
  bat_team_id   char(3),
  ab            int unsigned,
  h             int unsigned,
  ob            int unsigned,
  slg           decimal(5,3),
  hp            decimal(5,3),
  obp           decimal(5,3),
  h_last10      int unsigned
)
;
create index team_hitting_game_id on team_hitting (game_id, bat_team_id)
;

create table pitching (
  game_id      char(12),
  pit_team_id  char(3),
  bat_team_id  char(3),
  pit_id       char(8),
  pit_start_fl int,
  abp          int unsigned, -- ab pitched
  hp           int unsigned, -- hits pitched
  hpp          decimal(5,3)  -- hits pitched percent
)
;
create index pitching_game_id on pitching (game_id)
;
create index pitching_team_start_pit on pitching (game_id, bat_team_id, pit_start_fl)
;

create table bullpen (
  game_id      char(12),
  pit_team_id  char(3),
  abp          int unsigned, -- ab pitched
  hp           int unsigned, -- hits pitched
  hpp          decimal(5,3)  -- hits pitched percent
)
;
create index bullpen_game_id on bullpen (game_id)
;
create index bullpen_game_team on bullpen (game_id, pit_team_id)
;

create table streaker (
  streaker_id       int unsigned primary key auto_increment,
  game_id           char(12) not null,
  bat_team_id       char(3) not null,
  bat_lineup_id     int not null,
  bat_id            char(8) not null,
  bat_hand_cd       char(1) not null,
  h                 int unsigned not null,
  ab                int unsigned not null,
  hp                decimal(5,3) not null,
  slg               decimal(5,3) not null,
  h_last10          int unsigned not null,
  team_obp          decimal(5,3) not null,
  pit_team_id       char(3) not null,
  pit_id            char(8) not null,
  abp               int unsigned not null,
  hpp               decimal(5,3) not null,
  pit_hand_cd       char(1) not null,
  bp_abp            int unsigned not null,
  bp_hpp            decimal(5,3) not null,
  is_col_fl         int not null,
  daynight_park_cd  char(1) not null,
  temp_park_ct      int not null,
  base4_ump_id      char(8) not null,
  dh_fl             char(1) not null
)
;
