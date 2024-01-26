setopt interactivecomments
bindkey -e

pd=~/projects/gbif_db
wd=$pd/analysis/poc/gbif_api/s1
src=$pd/src
#db=$pd/analysis/main/data/database.db

mkdir -p $wd
mkdir $wd/data

cd $wd

#---- Download the dataset from the web query

wget -O data/ct_oaks.zip https://api.gbif.org/v1/occurrence/download/request/0073372-231120084113126.zip
unzip data/ct_oaks.zip -d data
mv data/0073372-231120084113126.csv data/ct_oaks.csv

#---- Download the dataset from rgbif

wget -O data/ct_oaks_rgbif.zip https://api.gbif.org/v1/occurrence/download/request/0075773-231120084113126.zip
unzip data/ct_oaks_rgbif.zip -d data
mv data/0075773-231120084113126.csv data/ct_oaks_rgbif.csv

#Run the report

qmd=$src/poc/reports/poc-gbif_api.qmd

fbase=${${qmd##*/}%.qmd} #Get file name without extenstion
out=$wd/reports/$fbase.html

mkdir -p ${out%/*}

quarto render $qmd -P wd:$wd
mv ${qmd%.*}.html $out
open $out
