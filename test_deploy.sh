#!/bin/bash
set -x
CHECK=$1
DATE=`date +"%Y-%m-%d-%H-%M"`
DEPLOYDIR="/domains/WEBSUPPLY_PRD/servers/AdminServer/upload"
MYHOME="/root/"
FILENAME="teste"
VALOR=`md5sum $MYHOME$FILENAME | awk -F" " '{print $1}'`
if [ $VALOR = $CHECK ] ; then
        echo "OK"
        echo "Criando cópia de Segurança"
        mv $DEPLOYDIR/$FILENAME $MYHOME/$FILENAME-$DATE
        echo "Fazendo Deploy"
        mv $MYHOME/$FILENAME $DEPLOYDIR/
else
        echo "FAIL"
fi
