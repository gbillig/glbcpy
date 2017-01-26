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
		num_files=$(ls -p "$src" | grep -v / | wc -l)
		cur_file=0
		#iterate over the contents of the src directory
		for src_file in "$src"/*
		do
			echo -ne "$((cur_file * 100 / num_files))%\r"
			#process only files
			if [ -f "$src_file" ]
			then
				src_md5_output=$(md5sum -b "$src_file")
				src_md5=${src_md5_output:0:32}

				#append filename to dst directory
				dst_file="$dst"/"${src_file##*/}"
				if [ -f "$dst_file" ]
				then
					dst_md5_output=$(md5sum -b "$dst_file")
					dst_md5=${dst_md5_output:0:32}

					if [ ! -s "$dst_file" ]
					then
						rm "$dst_file"
					else
						if [ "$src_md5" != "$dst_md5"]
						then
							echo "$dst_file"					
						fi	
					fi
				else
					echo "cp $src_file $dst/"
					#cp "$src_file" "$dst"/

					new_dst_md5_output=$(md5sum -b "$dst_file")
					new_dst_md5=${new_dst_md5_output:0:32}
					if [ "$src_md5" != "$new_dst_md5"]
					then
						echo "$dst_file"					
					fi
				fi
			fi 
			cur_file=$((cur_file + 1))
		done
	else
		echo "$src or $dst is not a valid directory"
		exit 1
	fi
fi
