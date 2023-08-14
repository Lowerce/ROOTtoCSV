# ROOTtoCSV
This is a shell script that takes one argument: the full path of a root file (or just the name+extension of the file if it's in the directory you run the macro from).  
The macro will make a .csv file from the root file.  
You must have ROOT installed to use this.  
NOTE that this version only works on a root file that has only one tree!

USAGE:
`./root2csv.sh <input.root>`
or
`./batch.sh`

You can not use this to convert a root file only with histogram.
