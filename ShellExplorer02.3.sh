#!/bin/bash

varstop=0				#Variable to end the programme
input=0				#Variable to save the user Commands
listed=0				#Variable to proof if there are Folders or Files in a directory
h=0					#Variable für die Funktionen hyphensbig und hyphensltl
yn=0					#Variable for Yes/No inputs
file=0					#Variable saves the Filetype
filend=0				#Variable to proof if it's a file or a folder
settings=0				#Variable for the input in Settings
sinput=0
ts=1
sudo=""
archive=0
setstop=0

reset

hyphensbig() {	#Function to automatically put out the right lenght of big hyphens (=)

if [ "$ts" = "1" ]
	then
		while [ "$h" != "$COLUMNS" ];
		do  
			echo -n "="
			((h=h+1))
		done
		echo ""
	else
	
	echo ""
fi

h=0

}

hyphensltl() {	#Function to automatically put out the right lenght of litle hyphens (-)
if [ "$ts" = "1" ]
	then
		while [ "$h" != "$COLUMNS" ];
		do  
			echo -n "-"
			((h=h+1))
		done
		echo ""
	else
	
	echo ""
fi

h=0

}

datalist() {
	echo "Files and Folders in directory" 
	echo "$PWD:"
	hyphensltl	#Function to automatically put out the directory's Files
	ls
}

hyphensbig
echo "ShellExplorer Version 02.3"
hyphensltl
echo "To read out the Documentation, type in '#help'"
hyphensbig

until [ "$varstop" = "1" ];
	do	
		while true;
		do
			datalist
			hyphensbig
			read -p "Command: " input					#Input of the User saved in the variable $input
			hyphensbig
		
			case $input in
			
				"#help") echo "The ShellExplorer is a (hopefully) easy to use Datamanager Programme."
					echo "This Documentation shows all possible Commands, this Programme can handle with."
					hyphensltl
					echo "Shortcuts:"
					hyphensltl
					echo "In this case, Shortcuts refer to commands that make it easier for the user to use the ShellExplorer or take on important functions (e.g. exiting the program) that have nothing to do with managing files and directories."
					echo "All shortcuts begin with the character '#'."
					hyphensltl
					echo "#exit\#quit\#q"
					echo "As the command already shows, you exit the ShellExplorer and the terminal will be cleaned up."
					hyphensltl
					echo "#/\#Home"
					echo "With this command you are forwarded directly to the directory /."
					hyphensltl
					echo "#desktop"
					echo "This Shortcut causes you to arrive at the "desktop directory"."
					hyphensltl
					echo "Filemanagement:"
					hyphensltl
					echo "This includes all commands that are required to manage files and directories (e.g. opening files)."
					hyphensltl
					echo "/[Folder]"
					echo "This command directs you to the next higher folder with the appropriate name."
					hyphensltl
					echo "<"
					echo "This command takes you back to the next lower directory."
					hyphensltl
					echo "[Programmename]"
					echo "This opens the file with the appropriate name and extension."
					echo "Not all file types are supported."
				;;
				
				"#exit") ;&
				"#Exit") ;&
				"#q") ;&
				"#quit") ;&
				"#Quit") varstop=1			#Loop will be interrupted
					break
				;;
				"#/") ;&
				"#Home") ;&
				"#home") cd /	#to get faster to /
				
				;;
				"#desktop") ;&
				"#Desktop")	cd $HOME/Schreibtisch/
						datalist
				;;
				"#media") ;&
				"#Media")	cd /media/
						datalist
				;;
				"<")	cd ..	#to go back in directory
				
				;;
				"#settings") ;&
				"#Settings")	reset
						setstop=0
						until [ "setstop" = "1" ];
						do
							hyphensbig
							echo "Settings:"
							hyphensltl
							echo "Activate/Deactivite hyphens (hy)"
							echo ""
							echo "Show Folders and directorys colorized (sc)"
							echo ""
							echo "Open Files as Administrator (admin)"
							echo ""
							echo "Close Settings (exit)"
							hyphensltl
								read -p "Option: " preference
								case $preference in
								
									"ts") 	echo "Activate/Deactivite hyphens?"
										hyphensltl
										read -p "[0/off(off)|1/on(on)]: " sinput
										case $sinput in
											"0") ;&
											"aus")	ts=0
												echo "Hyphens are now DEACTIVATED"
												sleep 1
												reset
											;;
											"1") ;&
											"an")	ts=1
												echo "Hyphens are now ACTIVATED"
												sleep 1
												reset
											;;
											*) 	echo "No Option for this setting."
												sleep 1
											;;
										esac
									;;
									"af") ;&
									"Af") ;&
									"AF")	echo "Colorize directorys?"
										hyphensltl
										read -p "[Y/N]: " sinput
										case $sinput in
											"Y") ;&
											"y")	LS_COLORS="fi=00;37;00:di=43;34;01:bd=47;32;04:"
												echo "Directorys will now be colorized"
												sleep 1
												reset
											;;
											"N") ;&
											"n")	LS_COLORS=""
												echo "Directorys will now NOT be colorized"
												sleep 1
												reset
											;;
											*) 	echo "No Option for this setting."
												sleep 1
											;;
										esac
									;;
									"admin") ;&
									"Admin") echo "Open files as admin?"
										read -p "[Y/N]: " sinput
										case $sinput in
											"Y") ;&
											"y") 	sudo="sudo"
												echo "Files will now be opened as admin"
												sleep 1
												reset
											;;
											"N") ;&
											"n")	unset $sudo
												echo "Files will now NOT be opened as admin"
												sleep 1
												reset
											;;
											*) 	echo "No Option for this setting."
												sleep 1
												reset
											;;
										esac
									;;
									"quit") ;&
									"exit") setstop=1
										echo "Settings will be closed..."
										sleep 1
										reset
										break
									;;
								esac
						done
				;; 
				*)	filend=$(find $PWD -name $input 2>/dev/null)
				
					if [ "$filend" = "$PWD/$input" ];
						then
							case "${input/*./}" in
								
								"txt") ;&
								"text") ;&
								"md")	file="Text -" archive=0
								;;
								"html") ;&
								"htm")	file="HTML -" archive=0
								;;
								"css")	file="Stylesheet -" archive=0
								;;
								"cpp") ;&
								"c++")	file="C++" archive=0
								;;
								"d") ;&
								"conf") file="Konfigurations -" archive=0
								;;
								"sh")	file="Shell Script -" archive=0
								;;
								"js")	file="Javascript -" archive=0
								;;
								"zip")	file="zip - Archive" archive=1 zipcommand="unzip $input"
								;;
								"tar")	file="tar - Archive" archive=1 zipcommand="tar xfv $input"
								;;
								"gz")	file="gz - Archive" archive=1 zipcommand="gzip -d $input"
								;;
								"bz2") file="bz2 - Archive" archive="1" zipcommand="bzip2 -d $input"
								;;
								*) 	echo "Dateityp unbekannt."
									break
								;;
							esac
							
							if [ "$archive" = 1 ];
								then
									echo "$input is a $file. Do you want to extract it now?"
									read -p "[J/N]: " yn
									if [ "$yn" = "J" ] || [ "$yn" = "j" ];
										then
											echo "Archive will be extracted..."
											$zipcommand
											yn=0
											echo "Archive extracted"
											hyphensbig
											sleep 0.8
											break
										else
											echo "Archive will NOT be extracted"
											yn=0
											hyphensbig
											sleep 0.8
											break
									fi
							fi
							
							echo "$input is a "$file" File. Do you want to open it?"
							read -p "[Y/N]:" yn
							if [ "$yn" = "Y" ] || [ "$yn" = "y" ];
								then
									$sudo nano $input
									yn=0
									reset
									hyphensbig
									break
								else
									hyphensltl
									echo "File will not be opened"
									sleep 0.5
									hyphensbig
									yn=0
									break
							fi
					fi
					
					if [ "$filend" = "" ];
						then
							if [ -d ./$input ] 2>/dev/null
								then
									cd ./$input
						
									listed=$(ls)
							
									if [ "$listed" = "" ];
										then
											echo "No Files or Folders were found in this directory"
									fi
					
								else
									echo "Directory doesn't exist!"
									hyphensbig
									sleep 1.2
							fi
					fi
			esac
		done
done

echo "Programme will be closed..."
sleep 1.2

echo "Terminal will be cleaned..."
sleep 0.8

unset varstop
unset input
unset listed
unset h
unset yn		#some Variables will be deleted
unset file
unset filend
unset settings
unset sinput
unset setstop
unset archive

sleep 0.8

reset	#Shell will be reseted

exit	#Programme will be closed
