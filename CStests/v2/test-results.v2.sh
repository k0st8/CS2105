#!/bin/bash

# Constants
RES=results
TESTS=./tests
SOL=./sol

# Define variable
fileName=$(basename $1)
dirName=$(dirname "$1")
tarName=${fileName%?}

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

	for i in $(seq 1 3);
	do

		 $SOL/"$fileName" < $TESTS/"$fileName"_test$i.in > ./$RES/"$fileName"_$i.out
		 ./"$fileName" < $TESTS/"$fileName"_test$i.in > ./$RES/"$fileName"_$i.hw.out

		 diff ./$RES/"$fileName"_$i.out ./$RES/"$fileName"_$i.hw.out
	done;	
fi
