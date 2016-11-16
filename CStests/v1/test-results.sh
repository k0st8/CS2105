#!/bin/bash
# something to change
for i in $(seq 1 3);
do
	g++ -Wall $1.cc -o $1 

	./sol/$1 < ./tests/$1_test$i.in > $1_$i.out
	./$1 < ./tests/$1_test$i.in > $1_$i.hw.out
	diff $1_$i.out $1_$i.hw.out
done;	
