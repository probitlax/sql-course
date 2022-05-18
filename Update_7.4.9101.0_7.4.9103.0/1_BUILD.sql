

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 132
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 999
SET ECHO OFF
SET verify OFF
SPOOL LOGS/BUILD.log

PROMPT ===========================================================
PROMPT
PROMPT DATABASE UPDATE : 
PROMPT FROM : 
PROMPT TO   : 
PROMPT
PROMPT CREATION DATE : 
PROMPT CREATOR : 
PROMPT 
PROMPT COMMENTS:
PROMPT ::
PROMPT ::
PROMPT ::
PROMPT ===========================================================
HOST PAUSE 


REM :: ------------------------------------------------------------
REM :: --------------------------
REM ::                          |
REM :: PART ONE                 |
REM :: DEFINE PARAMETERS        |
REM ::                          |
REM :: --------------------------

DEFINE  TABLESPACE_ONE = TS_ONE
DEFINE  TABLESPACE_ONE_LOB = TS_ONE_LOB
DEFINE  TABLESPACE_ONE_INDEX = TS_ONE_INDEX

DEFINE  TABLESPACE_TWO = TS_TWO
DEFINE  TABLESPACE_TWO_INDEX = TS_TWO_INDEX

REM ::  DO NOT USE SPACE CHAR IN THE VALUE OF THESE TWO PARAMETERS ::
DEFINE  ONE_DB_VERSION  = Version_7.4.9101.0
DEFINE  TWO_DB_VERSION = Version_7.4.9101.0



REM :: ------------------------------------------------------------
REM :: --------------------------
REM ::                          |
REM :: PART TWO                 |
REM :: GET DATA                 |
REM ::                          |
REM :: --------------------------

PROMPT ============================================================
PROMPT PLEASE ENTER NET SERVICE NAME (DATABASE NAME):
ACCEPT NET_SERVICE_NAME

PROMPT ============================================================
PROMPT PLEASE ENTER ONE USERNAME:
ACCEPT SCHEMA_ONE
PROMPT PLEASE ENTER ONE PASSWORD:
ACCEPT SCHEMA_ONE_PASSWORD HIDE
PROMPT ============================================================




REM :: ------------------------------------------------------------
REM :: --------------------------
REM ::                          |
REM :: PART THREE               |
REM :: CONNECT TO SCHEMAS AND   |
REM :: EXECUTE SCRIPT FILES     |
REM ::                          |
REM :: --------------------------

CONNECT &&SCHEMA_ONE/&&SCHEMA_ONE_PASSWORD@&&NET_SERVICE_NAME
PROMPT ========================= 1.ONE_UPDATE.sql
@@ONE_UPDATE1.sql &&TABLESPACE_ONE &&TABLESPACE_ONE_INDEX





REM :: ------------------------------------------------------------
REM :: --------------------------
REM ::                          |
REM :: PART FOUR                |
REM :: INSERT UPDATE VERSION    |
REM ::                          |
REM :: --------------------------

CONNECT &&SCHEMA_ONE/&&SCHEMA_ONE_PASSWORD@&&NET_SERVICE_NAME

PROMPT ========================= INSERT UPDATE VERSION
insert into db_version values(seq_db_version.nextval , '&&OA_DB_VERSION', sysdate , null,null,null);
commit;

PROMPT ==================================================================== 
PROMPT
PROMPT ........................ FINISHED SUCCESSFULLY.....................
PROMPT
PROMPT CHECK THE LOG FILES PLEASE AND REPORT ANY ERROR TO GAM DEVELOPE TEAM
PROMPT 
PROMPT ====================================================================
HOST PAUSE
SPOOL OFF
EXIT
