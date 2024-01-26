setopt interactivecomments
bindkey -e

pd=~/projects/gbif_db
wd=$pd/analysis/poc/duckdb/s1
src=$pd/src
db=$wd/data/gbif.db

mkdir -p $wd

cd $wd

#---- Get the download ---
wget -O data/acer.zip https://api.gbif.org/v1/occurrence/download/request/0075895-231120084113126.zip
unzip data/acer.zip -d data
mv data/0075895-231120084113126.csv data/acer.csv
rm data/acer.zip

wc -l 
#---- Create the database ---
cd data

duckdb $db

  #not sure how long this took, but it was < 5 min
  CREATE TABLE occ AS SELECT * FROM read_csv_auto('acer.csv');
  describe occ;
  
  select count(*) from occ; --2,551,668 rows

.quit

#---- Report ----
qmd=$src/poc/reports/poc-duckdb.qmd

fbase=${${qmd##*/}%.qmd} #Get file name without extenstion
out=$wd/reports/$fbase.html

mkdir -p ${out%/*}

quarto render $qmd -P wd:$wd
mv ${qmd%.*}.html $out
open $out
