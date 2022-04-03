#!/bin/bash
clear
echo "Cuants usuaris vols generar? Introdueix un nombre entre 1 i 100: "
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
rm nousUsuaris.ldif
touch nousUsuaris.ldif
NumUsr=$vinic
for ((i=0; i<$qt; i++ ))
do

idUsr=usr$NumUsr
echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" > nousUsuaris.ldif
echo "objectClass: top" >> nousUsuaris.ldif
echo "objectClass: person" >> nousUsuaris.ldif
echo "objectClass: organizationalPerson" >> nousUsuaris.ldif
echo "objectClass: inetOrgPerson" >> nousUsuaris.ldif
echo "objectClass: posixAccount" >> nousUsuaris.ldif
echo "objectClass: shadowAccount" >> nousUsuaris.ldif
echo "cn: $idUsr" >> nousUsuaris.ldif
echo "sn: $idUsr" >> nousUsuaris.ldif
echo "uidNumber: $NumUsr" >> nousUsuaris.ldif
echo "gidNumber: 100" >> nousUsuaris.ldif
echo "homeDirectory: /home/$idUsr" >> nousUsuaris.ldif
echo "loginShell: /bin/bash" >> nousUsuaris.ldif
echo "" >> nousUsuaris.ldif
NumUsr=$(( $NumUsr +1 ))

ldapadd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w "$ctsAdm" -f nousUsuaris.ldif

done
echo "Usuaris han sigut generats"
exit 0


