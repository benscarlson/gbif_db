setopt interactivecomments
bindkey -e

pd=~/projects/my_project
wd=$pd/analysis/main
src=$pd/src
db=$pd/analysis/main/data/database.db

mkdir -p $wd

cd $wd

qmd=$src/reports/myreport.qmd
out=$wd/reports/myreport.html

mkdir -p ${out%/*}

quarto render $qmd
mv ${qmd%.*}.html $out
open $out
