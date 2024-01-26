setopt interactivecomments
bindkey -e

pd=~/projects/gbif_db
src=$pd/src

cd $src/poc/reports

cp $BZY_QMD poc-gbif_api.qmd
cp $BZY_WF_QMD wf-poc-gbif_api.sh

cp $BZY_QMD poc-duckdb.qmd
cp $BZY_WF_QMD wf-poc-duckdb.qmd
