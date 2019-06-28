use streaker
;
load data local infile 'hitting.csv' into table hitting fields terminated by ','
;

load data local infile 'pitching.csv' into table pitching fields terminated by ','
;

load data local infile 'team-hitting.csv' into table team_hitting fields terminated by ','
;

load data local infile 'bullpen.csv' into table bullpen fields terminated by ','
;

create temporary table streaker_batting as
select
  g.year,
  g.game_start,
  g.game_id,
  h.bat_team_id,
  h.bat_lineup_id,
  h.bat_id,
  h.h,
  h.ab,
  h.hp,
  h.slg,
  h.h_last10,
  t.obp,
  case when g.park_id = 'DEN02' then 1 else 0 end is_col_fl,
  g.daynight_park_cd,
  g.temp_park_ct,
  g.base4_ump_id,
  g.dh_fl
from game g
join hitting h using (game_id)
join team_hitting t on g.game_id = t.game_id and h.bat_team_id = t.bat_team_id
order by g.game_start, g.game_id, bat_lineup_id
;
create index streaker_batting_team_year_player on streaker_batting(bat_team_id, year, bat_id)
;

create temporary table streaker_pitching as
select
  g.year,
  g.game_start,
  g.game_id,
  p.pit_team_id,
  p.bat_team_id,
  p.pit_id,
  p.abp,
  p.hpp,
  coalesce(bp.abp,0.00) as bp_abp,
  coalesce(bp.hpp,0.00) as bp_hpp
from game g
join pitching p on g.game_id = p.game_id
left join bullpen bp on p.game_id = bp.game_id and bp.pit_team_id = p.pit_team_id
where p.pit_start_fl = 1
order by g.game_start, g.game_id
;
create index streaker_pitching_team_pit_year on streaker_pitching(pit_team_id, pit_id, year)
;

create temporary table streaker_b as
select b.*, rb.bats
from streaker_batting b
join roster rb on b.year = rb.year and b.bat_team_id = rb.team_id and rb.player_id = b.bat_id
order by game_start, game_id, bat_lineup_id
;
create index streaker_b_game_bat_team on streaker_b(game_id, bat_team_id)
;
create temporary table streaker_p as
select p.*, r.throws
from streaker_pitching p
join roster r on p.year = r.year and p.pit_team_id = r.team_id and p.pit_id = r.player_id
order by game_start, game_id
;
create index streaker_p_game_bat_team on streaker_p(game_id, bat_team_id)
;

insert into streaker (
game_id,bat_team_id,bat_lineup_id,bat_id,bat_hand_cd,h,ab,hp,slg,h_last10,team_obp,pit_team_id,pit_id,abp,hpp,pit_hand_cd,bp_abp,bp_hpp,is_col_fl,daynight_park_cd,temp_park_ct,base4_ump_id,dh_fl)
select
  b.game_id,
  b.bat_team_id,
  b.bat_lineup_id,
  b.bat_id,
  b.bats,
  b.h,
  b.ab,
  b.hp,
  b.slg,
  b.h_last10,
  b.obp as team_obp,
  p.pit_team_id,
  p.pit_id,
  p.abp,
  p.hpp,
  p.throws,
  p.bp_abp,
  p.bp_hpp,
  b.is_col_fl,
  b.daynight_park_cd,
  b.temp_park_ct,
  b.base4_ump_id,
  b.dh_fl
from streaker_b b
join streaker_p p using(game_id, bat_team_id)
order by b.game_start, b.game_id
;
