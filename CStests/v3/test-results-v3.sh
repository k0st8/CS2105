#!/bin/bash

# Constants
RES=results
TESTS=./tests
SOL=./sol
SEE=./see-data

# Define variable
fileName=$(basename $1)
dirName=$(dirname "$1")
tarName=${fileName%?}

# Check if RES folder NOT exists
if [ ! -d "$RES" ]; then
	# Create folders
	mkdir $RES $TESTS $SOL $SEE
fi
# 
exists=`ls $TESTS/"$fileName"_test* 2> /dev/null | wc -l`
if [ $exists -eq 0 ]; then
	# Extract from files and move to folders
	tar xzvf "$tarName"sol.tgz -C $SOL && tar xfvz "$tarName"*Tests.tgz -C $TESTS
fi

testFile=$( ls $TESTS/"$fileName"_test* )
date 

if [ -e "$1.cc" ]; then

	g++ -Wall "$dirName/$fileName".cc -o "$fileName"
	chmod u+x "$fileName" # change user permissions for the file 

	for i in $testFile;
	do
 
		file_name=$(basename $i)
		$SOL/"$fileName"* < $i > ./$RES/$file_name.out
		./"$fileName" < $i > ./$RES/$file_name.hw.out

	 diff -y ./$RES/$file_name.out ./$RES/$file_name.hw.out
	done;

	#====================================================
	# Create file that shows results of School Solutions
	# Folder see-data and file see-data-<fileName>.txt
	#====================================================
	for i in $(ls $TESTS/"$fileName"*); do echo -e $i "\n"; cat $i && ./sol/"$fileName"* < $i; echo -e "\n";  done | tr -s " " '\t' > ./see-data/see-data-$fileName.txt
else 
	echo $1 " does not exists... check your path"  	
fi


