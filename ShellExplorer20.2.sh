#!/bin/bash

varstop=0				#Variable to end the programme
input=0				#Variable to save the user Commands
listed=0				#Variable to proof if there are Folders or Files in a directory
h=0					#Variable für die Funktionen hyphensbig und hyphensltl
yn=0					#Variable for Yes/No inputs
file=0					#Variable saves the Filetype
filend=0				#Variable to proof if it's a file or a folder

reset

hyphensbig() {	#Function to automatically put out the right lenght of big hyphens (=)

while [ "$h" != "$COLUMNS" ];
	do  
	echo -n "="
	((h=h+1))
done

echo ""

h=0

}

hyphensltl() {	#Function to automatically put out the right lenght of little hyphens (-)

while [ "$h" != "$COLUMNS" ];
	do  
	echo -n "-"
	((h=h+1))
done

echo ""

h=0

}

datalist() {
	echo "Files and Folders in directory" 
	echo "$PWD:"
	hyphensltl	#Function to automatically put out the directory's Files
	ls
}

hyphensbig
echo "ShellExplorer Version 20.2"
hyphensltl
echo "To read out the Documentation, type in '#help'"
hyphensbig
datalist

until [ "$varstop" = "1" ];
	do	
		while true;
		do
			hyphensbig
			read -p "Command: " input					#Input of the User saved in the variable $input
			hyphensbig
		
			case "$input" in
			
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
				"#Quit") varstop=1			#Loop will break
					break
				;;
				"#/") ;&
				"#Home") ;&
				"#home") cd /
					datalist			#to get faster to /
				;;
				"#desktop") ;&
				"#Desktop") cd $HOME/Desktop/
						datalist
				;;
				"<")	cd ..
					datalist			#to go back in directory
				;; 
				*)	filend=$(find $PWD -name $input 2>/dev/null)
				
					if [ "$filend" = "$PWD/$input" ];
						then
							case "${input/*./}" in
								
								"txt") ;&
								"text") file="Text -"
								;;
								"html") ;&
								"htm") file="HTML -"
								;;
								"css") file="Stylesheet -"
								;;
								"cpp") ;&
								"c++") file="C++"
								;;
								"d") ;&
								"conf") file="Configuration -"
								;;
								"sh") file="Shell Script -"
								;;

							esac
							
							echo "$input is a "$file" File. Do you want to open it?"
							read -p "[Y/N]:" yn
							if [ "$yn" = "Y" ] || [ "$yn" = "y" ];
								then
									nano $input
									yn=0
									reset
									hyphensbig
									datalist
									break
								else
									hyphensltl
									echo "File won't be opened"
									sleep 0.5
									hyphensbig
									datalist
									yn=0
									break
							fi
					fi
					
					if [ "$filend" = "" ];
						then
							if [ -d ./$input ]
								then
									cd ./$input
									datalist
						
									listed=$(ls)
							
									if [ "$listed" = "" ];
										then
											echo "No Files or Folders were found in this directory"
									fi
					
								else
									echo "Directory doesn't exist!"
									hyphensltl
									ls
							fi
					fi
			esac
		done
done

sleep 1

echo "Programme will be closed..."
sleep 1.2

echo "Terminal will be cleaned..."
sleep 0.8

reset	#Shell will be reseted

exit	#Programme will be closed
