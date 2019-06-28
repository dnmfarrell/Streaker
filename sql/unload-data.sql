-- there are fewer rows with no hits than hits
select @maxrows:=count(1) from streaker where h = 0;
set @trainrows = round(@maxrows*0.7);
set @validrows = round(@maxrows*0.15);

prepare streaker_hit from
"create temporary table streaker_hit as
select
  case when h > 0 then 1 else 0 end as h,
  bat_lineup_id,
  ab,
  hp,
  slg,
  h_last10,
  team_obp,
  case when bat_hand_cd = 'L' and pit_hand_cd = 'L' then 0
       when bat_hand_cd = 'R' and pit_hand_cd = 'R' then 1
       when bat_hand_cd = 'L' and pit_hand_cd = 'R' then 2
       else 3 end handedness,
  abp,
  hpp,
  bp_abp,
  bp_hpp,
  is_col_fl,
  case when daynight_park_cd = 'N' then 1 else 0 end daynight,
  case when dh_fl = 'T' then 1 else 0 end dh_fl
from streaker
where h > 0
order by rand() limit ?"
;
execute streaker_hit using @maxrows;

prepare streaker_no_hit from
"create temporary table streaker_no_hit as
select
  case when h > 0 then 1 else 0 end as h,
  bat_lineup_id,
  ab,
  hp,
  slg,
  h_last10,
  team_obp,
  case when bat_hand_cd = 'L' and pit_hand_cd = 'L' then 0
       when bat_hand_cd = 'R' and pit_hand_cd = 'R' then 1
       when bat_hand_cd = 'L' and pit_hand_cd = 'R' then 2
       else 3 end handedness,
  abp,
  hpp,
  bp_abp,
  bp_hpp,
  is_col_fl,
  case when daynight_park_cd = 'N' then 1 else 0 end daynight,
  case when dh_fl = 'T' then 1 else 0 end dh_fl
from streaker
where h = 0
order by rand() limit ?"
;
execute streaker_no_hit using @maxrows;

prepare streaker_training from
"select h,bat_lineup_id,ab,hp,slg,h_last10,team_obp,handedness,abp,hpp,bp_abp,bp_hpp,is_col_fl,daynight,dh_fl into outfile '/tmp/streaker-training.csv' fields terminated by ',' from ((select * from streaker_no_hit limit ?) union all (select * from streaker_hit limit ?))x order by rand()";
execute streaker_training using @trainrows, @trainrows;

prepare streaker_valid from
"select h,bat_lineup_id,ab,hp,slg,h_last10,team_obp,handedness,abp,hpp,bp_abp,bp_hpp,is_col_fl,daynight,dh_fl into outfile '/tmp/streaker-validation.csv' fields terminated by ',' from ((select *, ROW_NUMBER() OVER() as rn from streaker_no_hit) union all (select *, ROW_NUMBER() OVER() as rn from streaker_hit))x where rn > ? and rn <= ? + ? order by RAND()";
execute streaker_valid using @trainrows, @trainrows, @validrows;

prepare streaker_test from
"select h,bat_lineup_id,ab,hp,slg,h_last10,team_obp,handedness,abp,hpp,bp_abp,bp_hpp,is_col_fl,daynight,dh_fl into outfile '/tmp/streaker-test.csv' fields terminated by ',' from ((select *, ROW_NUMBER() OVER() as rn from streaker_no_hit) union all (select *, ROW_NUMBER() OVER() as rn from streaker_hit))x where rn > ? + ? order by RAND()";
execute streaker_test using @trainrows, @validrows;
