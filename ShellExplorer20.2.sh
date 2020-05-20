#!/bin/bash

varstop=0				#Variable zum beenden des Programms
input=0				#Variable zum Speichern der Benutzereingaben
listed=0				#Variable zum Überprüfen, ob sich Dateien in einem Verzeichnis befinden
h=0					#Variable für die Funktionen hyphensbig und hyphensltl
yn=0					#Variable für Ja/Nein Eingaben
file=0					#Variable speichert den Dateityp
filend=0				#Variable zum überprüfen, ob Datei oder Ordner

reset

hyphensbig() {	#Funktion zum automatischen ausgeben der großen Trennstriche (=)

while [ "$h" != "$COLUMNS" ];
	do  
	echo -n "="
	((h=h+1))
done

echo ""

h=0

}

hyphensltl() {	#Funktion zum automatischen ausgeben der kleinen Trennstriche (-)

while [ "$h" != "$COLUMNS" ];
	do  
	echo -n "-"
	((h=h+1))
done

echo ""

h=0

}

datalist() {
	echo "Dateien und Ordner im Verzeichnis" 
	echo "$PWD:"
	hyphensltl	#Funktion zum automatischen Ausgeben der Ordnerstruktur
	ls
}

hyphensbig
echo "ShellExplorer Version 20.2" #Begrüßung
hyphensltl
echo "Zum Anzeigen der Dokumentation '#help' eingeben"
hyphensbig
datalist

until [ "$varstop" = "1" ];
	do	
		while true;
		do
			hyphensbig
			read -p "Eingabe: " input					#Eingabe des Benutzers wird in $input gespeichert
			hyphensbig
		
			case "$input" in
			
				"#help") echo "Der Shellexplorer ist ein (hoffentlich) einfach zu bedienendes Dateimanager Programm."
					echo "Diese Dokumentation zeigt alle möglichen Befehle, die dieses Programm ausführen kann."
					hyphensltl
					echo "Kurzbefehle:"
					hyphensltl
					echo "Als Kurzbefehle sind in diesem Fall Kommandos gemeint, die dem Benutzer das Bedienen des ShellExplorers einfacher machen oder wichtige Funktionen (z.B. Beenden des Programms) übernehmen, die nichts mit dem Verwalten von Dateien und Verzeichnissen zu tun haben."
					echo "Alle Kurzbefehle beginnen mit dem Zeichen #."
					hyphensltl
					echo "#exit\#quit\#q"
					echo "Wie der Befehl schon zeigt, beendet man damit den ShellExplorer und das Terminal wird aufgeräumt."
					hyphensltl
					echo "#/\#Home"
					echo "Mit diesem Befehl wird man direkt in das Verzeichnis / weitergeleitet."
					hyphensltl
					echo "#desktop\#schreibtisch"
					echo "Dieser Befehl bewirkt, dass man auf dem "Desktop-Verzeichnis" ankommt."
					hyphensltl
					echo "Dateiverwaltung:"
					hyphensltl
					echo "Das schließt alle Kommandos ein, die zum Verwalten von Dateien und Verzeichnissen benötigt werden (z.B. Öffnen von Dateien)."
					hyphensltl
					echo "/[Ordner]"
					echo "Dieser Befehl leitet einem zum nächst höher gelegenem Ordner mit dem passenden Namen."
					hyphensltl
					echo "<"
					echo "Mit diesem Kommando kommt man in das nächst tiefere Verzeichnis zurück."
					hyphensltl
					echo "[Programmname]"
					echo "Damit öffnet man die Datei mit dem passenden Namen und Endung."
					echo "Nicht alle Dateitypen werden unterstützt."
				;;
				
				"#exit") ;&
				"#Exit") ;&
				"#q") ;&
				"#quit") ;&
				"#Quit") varstop=1			#Schleife wird unterbrochen
					break
				;;
				"#/") ;&
				"#Home") ;&
				"#home") cd /
					datalist			#um schneller nach / zu kommen
				;;
				"#desktop") ;&
				"#Desktop") ;&
				"#schreibtisch") ;&
				"#Schreibtisch")	cd $HOME/Schreibtisch/
							datalist
				;;
				"<")	cd ..
					datalist			#um zum vorherigen Punkt zurückzugehen
				;; 
				*)	filend=$(find $PWD -name $input 2>/dev/null)
				
					if [ "$filend" = "$PWD/$input" ]; #Erkennung der Dateien funktioniert noch nicht...
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
								"conf") file="Konfigurations -"
								;;
								"sh") file="Shell Script -"
								;;

							esac
							
							echo "$input ist eine "$file" Datei. Möchten sie diese öffnen?"
							read -p "[J/N]:" yn
							if [ "$yn" = "J" ] || [ "$yn" = "j" ];
								then
									nano $input
									yn=0
									reset
									hyphensbig
									datalist
									break
								else
									hyphensltl
									echo "Datei wird nicht geöffnet"
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
											echo "Keine Dateien oder Ordner in diesem Verzeichnis gefunden"
									fi
					
								else
									echo "Ordner existiert nicht! Bitte anderes Verzeichnis wählen"
									hyphensltl
									ls
							fi
					fi
			esac
		done
done

sleep 1

echo "Programm wird geschlossen..."
sleep 1.2

echo "Terminal wird aufgeräumt..."
sleep 0.8

reset	#Shell wird zurückgesetzt

exit	#Programm wird geschlossen
