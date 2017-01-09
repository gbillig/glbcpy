#!/bin/bash

if [ "$1" = "-h" -o "$1" = "--help" ]
then
	echo "Help Message"
	echo "-i INPUT_DIR"
	echo "-o OUTPUT_DIR"
	exit 1
fi

if [ "$1" = "-i" -a "$3" = "-o" ]
then
	src=$2
	dst=$4
	if [ -d "$src" -a -d "$dst" ]
	then
		echo "ok copy"
	else
		echo "$src or $dst is not a valid directory"
		exit 1
	fi
fi
