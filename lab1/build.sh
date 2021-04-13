#!/bin/bash

if [ -z $1 ]; then
	echo Error: Filename is not found in args
	exit 1
else
	if [ -e $1 ]; then 
	
		if [ -z $2 ]; then 
			echo Error: Invalid output file argument
			exit 1
		else
			TMPFOLDER=`mktemp -d`
			CURRENTFOLDER=$(pwd)
			
			trap "rm -Rf $TMPFOLDER; exit 1" SIGINT SIGHUP SIGTERM
			
			cp $1 $TMPFOLDER/
			cd $TMPFOLDER
			
			gcc $1 -o $2
			
			if [ $? -eq 0 ]; then 
				mv $2 "$CURRENTFOLDER"
				cd "$CURRENTFOLDER"
				rm -Rf $TMPFOLDER
				echo Success: Build stored at $2
			else
				echo Error: Compilation error
				cd "CURRENTFOLDER"
				rm -Rf $TMPFOLDER
				exit 1
			fi
		fi
	else
		echo Error: Source file $1 doesn\'t exist
		exit 1
	fi
fi
