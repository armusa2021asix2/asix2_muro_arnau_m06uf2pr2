#!/bin/bash
clear
echo "Cuants usuaris vols asignarli contrasenya? Introdueix un nombre entre 1 i 100: "
read qt
if [[ $qt -lt 1 ]] || [[ $qt -gt 100 ]]
then
echo "ERROR el nombre ha de ser entre 1 i 100"
exit 1
fi
echo "Valor UID (Ha de ser 5000 o major): "
read vinic
#vinic=$((vinic-1))
if (( vinic <= 5000 ))
then
echo "ERROR UID ha de ser igual o major que 5000"
exit 1
fi
echo "Contrasenya admin ldap: "
read ctsAdm
rm ctsUsuaris.txt
touch ctsUsuaris.txt
NumUsr=$vinic
for ((i=0; i<$qt; i++ ))
do

idUsr=usr$NumUsr
ctsnya=$(pwgen 10 1)
echo "$idUsr $ctsnya" > ctsUsuaris.txt
echo "objectClass: top" >> ctsUsuaris.txt
echo "objectClass: person" >> ctsUsuaris.txt
echo "objectClass: organizationalPerson" >> ctsUsuaris.txt
echo "objectClass: inetOrgPerson" >> ctsUsuaris.txt
echo "objectClass: posixAccount" >> ctsUsuaris.txt
echo "objectClass: shadowAccount" >> ctsUsuaris.txt
NumUsr=$(( $NumUsr +1 ))

ldappasswd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w "$ctsAdm" -S "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> ctsUsuaris.txt

done
echo "Contrasenya creada"
exit 0

