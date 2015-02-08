#!/bin/bash

####Use: ./root2csv.sh argv1
###argv1 is the full path + file name of the root file you wish to convert

INPUT_ROOT=$1
ROOT_NAME=$1

####Make an appropriately name for the new .csv file

needle="/"
num_slash=$(grep -o "$needle" <<< "$INPUT_ROOT" | wc -l)

  COUNTER=0
  while [ $COUNTER -lt $num_slash ]; do
      ROOT_NAME=`echo ${ROOT_NAME#*/}`
      let COUNTER=COUNTER+1
  done
  
root_ending=".root"
csv_ending=".csv"

CSV_NAME=${ROOT_NAME//$root_ending/$csv_ending}

echo "The full path of the .root file is "$INPUT_ROOT
echo "The name of the .root file is "$ROOT_NAME
echo "The name of the new .csv file is "$CSV_NAME

###Replace the placeholder in the execute.sh script with the fullpath

input_with_quotes='"'$INPUT_ROOT'"'
sed -e "s|BARFOO|$input_with_quotes|g" execute.sh > executeTEMP.sh

###Run the executeTEMP file to generate the bulkCSV.txt and namesCSV.txt files
##bulkCSV.txt holds most of the info for the new csv file, but with poor formatting and incomplete names
##namesCSV.txt will make up the first line of the new csv file

chmod a+x executeTEMP.sh
./executeTEMP.sh
number_files_gened=`ls *CSV.txt | grep -c .`

#if [ "$number_files_gened" -ne 2 ]
#	then
#		echo "The files bulkCSV.txt and/or namesCSV.txt were not generated!"
#		echo "Check ROOTtoCSV.C compiles and/or works...
#		echo "Program exiting."
#		
#		exit
#fi
#This doesn't work for now, I need to fix it later

rm executeTEMP.sh

###Format correctly the bulkCSV.txt file and pipe it to the csv file

sed -e "1d" -e "2d" -e "3d" -e "s|*||g" bulkCSV.txt > intermed1.txt
tr -s '[:blank:]' ',' <intermed1.txt > intermed2.txt
rm intermed1.txt
less intermed2.txt | cut -c 2- > intermed3.txt
rm intermed2.txt
sed 's/,$//' intermed3.txt > intermed.csv
rm intermed3.txt

###Add the row of names

cat namesCSV.txt intermed.csv > $CSV_NAME

rm intermed.csv
rm bulkCSV.txt
rm namesCSV.txt
