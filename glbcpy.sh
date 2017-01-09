#!/bin/bash

#use extended pattern matching
shopt -s extglob;

if [ "$1" = "-h" -o "$1" = "--help" ]
then
	echo "Help Message"
	echo "-i INPUT_DIR"
	echo "-o OUTPUT_DIR"
	exit 1
fi

#process input and output directories
if [ "$1" = "-i" -a "$3" = "-o" ]
then

	#remove trailing slashes for src and dst
	if [ "$2" != "/" ]
	then
		src=${2%%+(/)}
	else
		src=$2
	fi

	if [ "$4" != "/" ]
	then
		dst=${4%%+(/)}
	else
		dst=$4
	fi

	#make sure that the args are valid directories
	if [ -d "$src" -a -d "$dst" ]
	then
		#iterate over the contents of the src directory
		for filename in "$src"/*
		do
			#process only files
			if [ -f "$filename" ]
			then
				#append filename to dst directory
				echo "$dst"/"${filename##*/}"
				#if [ -f "$dst"/"${
			fi 
		done
	else
		echo "$src or $dst is not a valid directory"
		exit 1
	fi
fi
