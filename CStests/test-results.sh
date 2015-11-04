#!/bin/bash

#===================
# Dowload school tests files 
# 1. unzip
# 	1. create sol (folder)
# 		1. copy all executables here
#	2. create tests (folder) 
# 		1. copy all test files here
# 
# 3. run this script without cc
# ./test-results.sh <exercise name> 
#=====================

for i in $(seq 1 3);
do
	g++ -Wall $1.cc -o $1 

	./sol/$1 < ./tests/$1_test$i.in > $1.out
	./$1 < ./tests/$1_test$i.in > $1_hw
done;	

diff $1.out $1_hw
