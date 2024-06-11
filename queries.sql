--v_games_normalized
SELECT 
    upper(gamename) AS game,
    TRIM(console) AS console,
    review,
    score
FROM flawless-age-425110-i9.gamespot.games,
    UNNEST(SPLIT(console, ',')) AS console;

-------------------------------------------------------------------------------------------------

--v_games_pc
with SQ as
(
  select distinct game, review, score, rank() over (partition by game order by score desc) as RNK 
  from flawless-age-425110-i9.gamespot.v_games_normalized
where console='PC'
)
select * from sq where rnk =1;

-------------------------------------------------------------------------------------------------

--v_games_ps4
with SQ as
(
  select distinct game, review, score, rank() over (partition by game order by score desc) as RNK 
  from flawless-age-425110-i9.gamespot.v_games_normalized
where console='PS4'
)
select * from sq where rnk =1;

-------------------------------------------------------------------------------------------------

--v_games_xone
with SQ as
(
  select distinct game, review, score, rank() over (partition by game order by score desc) as RNK 
  from flawless-age-425110-i9.gamespot.v_games_normalized
where console='PC'
)
select * from sq where rnk =1;

-------------------------------------------------------------------------------------------------

--v_games_scores_per_console
WITH PC as
(
  select distinct score, count(*) as CNT from flawless-age-425110-i9.gamespot.v_games_pc group by 1
)
,PS4 AS
(
  select  distinct score, count(*) as CNT from flawless-age-425110-i9.gamespot.v_games_ps4 group by 1
)
,XONE AS
(
  select  distinct score, count(*) as CNT from flawless-age-425110-i9.gamespot.v_games_xone group by 1
)
SELECT 'PC' as CONSOLE, PC.SCORE as SCORE, PC.CNT as NUMBER_OF_OCCURENCES FROM PC
union all
SELECT 'PS4' as CONSOLE, PS4.SCORE as SCORE, PS4.CNT as NUMBER_OF_OCCURENCES FROM PS4
union all
SELECT 'XONE' as CONSOLE, XONE.SCORE as SCORE, XONE.CNT as NUMBER_OF_OCCURENCES FROM XONE;

-------------------------------------------------------------------------------------------------

--v_games_top_count_per_console
select 'PC' as CONSOLE, count(*) as NUMBER_OF_TOP_SELLERS from flawless-age-425110-i9.gamespot.v_games_pc where score>=9
union all
select 'PS4' as CONSOLE, count(*) as NUMBER_OF_TOP_SELLERS from flawless-age-425110-i9.gamespot.v_games_ps4 where score>=9
union all
select 'XONE' as CONSOLE, count(*) as NUMBER_OF_TOP_SELLERS from flawless-age-425110-i9.gamespot.v_games_xone where score>=9;
