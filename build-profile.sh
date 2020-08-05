#!/usr/bin/env sh

cd `dirname $0`

EXPERDB_AGENT=eXperDB_Agent
EXPERDB_AGENT_HOME=$SCRIPT_DIR
export EXPERDB_AGENT_HOME
EXPERDB_INSTALL_DIR=$EXPERDB_AGENT_HOME/install/eXperDB_Server
EMA=eXperDB_Monitoring_Agent
EMAM=eXperDB_Monitoring_Agent_Manager
EMA_DIR_NAME=eXperDBMA
EMAM_DIR_NAME=eXperDBMA_MANAGER

PGPROFILE_VERSION=`head -n 1 Makefile | awk  '{print $3}'`
SCHEMA="schema.sql internal.sql"
ADM_FUNCS="baseline.sql node.sql"
SNAPSHOT=snapshot.sql
REPORT="dbstat.sql statementstat_dbagg.sql clusterstat.sql tablespacestat.sql tablestat.sql indexstat.sql dead_mods_ix_unused.sql top_io_stat.sql functionstat.sql settings.sql statements_checks.sql statementstat.sql report.sql reportdiff.sql"
SCRIPT="$SCHEMA $ADM_FUNCS $SNAPSHOT $REPORT"
cat ${SCRIPT} | sed -e 's/SET search_path=@extschema@,public //' > pg_profile--${PGPROFILE_VERSION}.sql
MAKECONTROL="sed -e 's/{version}/${PGPROFILE_VERSION}/' pg_profile.control.tpl > pg_profile.control"
eval ${MAKECONTROL}
echo "...done"