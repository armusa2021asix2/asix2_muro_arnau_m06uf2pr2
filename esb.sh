#!/bin/bash
clear
echo "esb.sh"

case $1 in 
	-e) if (( $# != 3 ))
		then
			echo "Numero de paràmetres incorrecte"
			echo "L'opció -e necessita 3 paràmetres"
			echo "La primera opció es -e"
			echo "La segona opció ha de ser l'extensio dels fitxers que vols enviar"
			echo "La tercera opció ha de ser el directori on es troben els fitxers"
			exit 2
		fi
		if [[ ! -d ~/paperera ]]
		then
			mkdir ~/paperera
		fi
		if [[ ! -d $3 ]]
		then
			echo "La carpeta no existeix"
		else
			if [[ $(ls -A $3/*.$2 2> /dev/null | wc -l) -ne 0 ]]
			# Comprova si hi ha fitxers amb l'extensió demanada dins del directori. 
			# 2> /dev/null és per redireccionar avisos extres del bash.
			# 
			then
				mv $3/*.$2 ~/paperera
				echo "Fitxers enviats a paperera"
			else
				echo "No existeixen els fitxers amb l'extensió indicada"
			fi
		 fi
		 ;;	 
	-r) if (( $# != 1 )) 
		then
			echo "Nombre de paràmetres incorrecte"
			echo "L'opció -r no necessita altres paràmetres"
			exit 1
		fi
		if [[ ! -d ~/paperera ]]
		then
			echo "Paperera no existeix"
		else
			if [[ $(ls -A ~/paperera | wc -l) -ne 0 ]]
			# Compte el número de fitxers d'una carpeta. Si la paperera està buida no cal intentar buidar-la 
			then
				rm ~/paperera/* #Això buida la paperera però no esborra el directori paperera
				echo "Paperera buidada"
			else
				echo "La paperera ja està buida" # Això estrictament no ho demana l'enunciat 
			fi
		fi
		;;	
	*)  echo "Primer paràmetre es incorrecte o no has posat cap"
	    echo "Utilització: "
	    echo "-r per buidar la paperera"
	    echo "-e per enviar fitxers a la paperera"
	    exit 3
	    ;;
esac
exit 0
