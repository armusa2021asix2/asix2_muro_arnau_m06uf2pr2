#! /bin/bash
echo "resolv.sh"
echo
if (( $# == 1 ))
then
	if [[ ! -d /root/$1 ]]
	then
		echo -n "El directori no existeix, Vol crear-lo (s/n)?: "
		read opc
		if [[ $opc != "s" ]] && [[ $opc != "S" ]]
		then
		echo $opc
		echo "No sha volgut crear el subdirectori"
		exit 1
		else
			mkdir /root/$1
		fi
	fi
else
	echo "S'ha de posar un paràmetre sudo ./resolv.sh [nomdelacarpeta]"
	exit 2
fi
nom_backup=/root/$1/resolv.conf.backup.$(date +"%Y%m%d%H%M")
cp /etc/resolv.conf $nom_backup 
gzip $nom_backup
echo "Felicitats has pogut crear el gzip"
exit 0
