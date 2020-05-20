#!/bin/bash

echo "ShellExplorer Version 1.0
================================================"
echo "Ordner und Dateien in diesem Verzeichnis:
------------------------------------------------"

ls

echo "-------------------------------------------------"

varnext=0
varnow=0
varstop=0

until [ "$varstop" = "1" ]

	do
		read -p "Eingabe: " varnext
		if [ "$varnext" = "Exit" ]
			then
				echo "Programm beendet"
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
								echo "Verzeichnis nicht gefunden"
						fi
				fi		
		fi
done
