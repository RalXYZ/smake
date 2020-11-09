#!/bin/sh
smake_operand=$1
case "$smake_operand" in
	compile)
		echo "ccc"
		gcc -c *.c
		if [ $? -ne 0 ]
		then
			echo "smake: smake didn't sucessfully compile because some errors arose wile compiling."
			exit 1
		fi
		gcc *.o
		if [ $? -ne 0 ]
		then
			echo "smake: smake didn't sucessfully compile because some errors arose while linking."
			exit 2
		fi;;
	*)
		echo "smake usage:"
		echo "smake compile"
		echo "smake install DESTINATION INSTALLFILELIST"
		echo "smake clean"
		if [ "$smake_operand" = help ]
		then
			exit 0
		else
			exit 127
		fi;;
esac
