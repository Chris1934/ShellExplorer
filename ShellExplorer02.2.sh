#!/bin/bash

varstop=0				#Variable to end the programme
input=0				#Variable to save the user Commands
listed=0				#Variable to proof if there are Folders or Files in a directory
h=0

reset

hyphensbig() {

while [ "$h" != "$COLUMNS" ];
	do  
	echo -n "="
	((h=h+1))
done

echo ""

h=0

}

hyphensltl() {

while [ "$h" != "$COLUMNS" ];
	do  
	echo -n "-"
	((h=h+1))
done

echo ""

h=0

}

datalist() {
	echo "Data and Folders in this directory:" 
	echo "$PWD:"
	hyphensltl	#Function to automatically put out the directory's Files
	ls
}

hyphensbig
echo "ShellExplorer Version 1.1" #Greet
hyphensbig
datalist

until [ "$varstop" = "1" ]
	do	
		hyphensbig
		read -p "Command: " input
		hyphensbig
		
		case "$input" in
		
			"quit") varstop=1			#Loop will break
			;;
			"#home") cd /
				datalist			#to go faster to /
			;;
			"#desktop")	cd $HOME/Desktop/
						datalist
			;;
			"<")	cd ..
				datalist			#to go back
			;;
			*)	if [ -d ./$input ];
					then
						cd ./$input
						datalist
						
						listed=$(ls)
						
						if [ "$listed" = "" ];
							then
								echo "No Files or Folders were found in this directory"
						fi
					
					else
						echo "Directory doesn't exist."
						datalist
						hyphensbig
						ls
				fi
		esac
done

sleep 1

echo "Programme will be closed"
sleep 1.2

echo "Terminal will be reopened"
sleep 0.8

reset	#Shell will be reset

exit	#Programme will be closed
