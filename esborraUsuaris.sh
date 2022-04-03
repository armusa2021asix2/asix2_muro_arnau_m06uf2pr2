#!/bin/bash
clear
echo "Cuants usuaris vols esborrar? Introdueix un nombre entre 1 i 100: "
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
rm esborraUsuaris.ldif
touch esborraUsuaris.ldif
NumUsr=$vinic
for ((i=0; i<$qt; i++ ))
do

idUsr=usr$NumUsr
echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" > esborraUsuaris.ldif
echo "changetype: delete" >> esborraUsuaris.ldif
echo "" >> esborraUsuaris.ldif
NumUsr=$(( $NumUsr +1 ))

ldapmodify -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w "$ctsAdm" -f esborraUsuaris.ldif

done
echo "Usuaris han sigut esborrats"
exit 0

