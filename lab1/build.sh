#!/bin/bash

if [ -z $1 ]; then
	echo Error: Filename is not found in args
	exit 1
else
	if [ -e $1 ]; then 
	
		FILENAME=`grep Output $1`
			
                if [ $? -eq 0 ]; then
			
			FILENAME=${FILENAME#//Output:}

			echo $FILENAME

			if [ -z $FILENAME ]; then 
				echo Error: Invalid destination file name
				exit 1
			else
				TMPFOLDER=`mktemp -d`
				CURRENTFOLDER=$(pwd)
				
				trap "rm -Rf $TMPFOLDER; exit 1" SIGINT SIGHUP SIGTERM
				
				cp $1 $TMPFOLDER/
				cd $TMPFOLDER
				
				gcc $1 -o $FILENAME
				
				if [ $? -eq 0 ]; then 
					mv $FILENAME "$CURRENTFOLDER"
					cd "$CURRENTFOLDER"
					rm -Rf $TMPFOLDER
					echo Success: Build stored at $FILENAME
				else
					echo Error: Compilation error
					cd "CURRENTFOLDER"
					rm -Rf $TMPFOLDER
					exit 1
				fi
			fi
		else
			echo Error: Destination file name is not specified in the source file.
			echo Error: Use \"//Output: *file_name*\" in order to specify the destination
		fi
	else
		echo Error: Source file $1 doesn\'t exist
		exit 1
	fi
fi
