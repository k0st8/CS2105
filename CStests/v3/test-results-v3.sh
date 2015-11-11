#!/bin/bash

# Constants
RES=results
TESTS=./tests
SOL=./sol

# Define variable
fileName=$(basename $1)
dirName=$(dirname "$1")
tarName=${fileName%?}
testFile=$( ls $TESTS/"$fileName"_test* )
# Check if RES folder NOT exists
if [ ! -d "$RES" ]; then
	# Create folders
	mkdir $RES $TESTS $SOL
	# Extract from files and move to folders
	tar xzvf "$tarName"sol.tgz -C $SOL && tar xfvz "$tarName"_fullTests.tgz -C $TESTS 
fi
date 
if [ -e "$1.cc" ]; then

	g++ -Wall "$dirName/$fileName".cc -o "$fileName"

	for i in $testFile;
	do
 
		file_name=$(basename $i)
		$SOL/"$fileName" < $i > ./$RES/$file_name.out
		./"$fileName" < $i > ./$RES/$file_name.hw.out

	 diff ./$RES/$file_name.out ./$RES/$file_name.hw.out
	done;	
fi
