#!/bin/bash

echo "ShellExplorer Version 1.0
================================================"
echo "Data and folders in this directory:
------------------------------------------------"

ls

echo "-------------------------------------------------"

varnext=0
varnow=0
varstop=0

until [ "$varstop" = "1" ]

	do
		read -p "Command: " varnext
		if [ "$varnext" = "Exit" ]
			then
				echo "Programme stopped"
				varstop=1
			else
				if [ "$varnext" = "Home" ]
					then
							cd /
							ls
				fi
				
				if [ "$varnext" = "<" ]
					then
						cd ..
						ls
					else
				
						if [ -d ./$varnext ]
							then
								cd ./$varnext
								ls
							else	
								echo "Directory not found"
						fi
				fi		
		fi
done
