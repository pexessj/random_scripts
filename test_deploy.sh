#!/bin/bash
set -x
DATE=`date +"%d-%m-%Y"`
MYHOME="/home/ec2-user/"
FILENAME="wasp-api"
DEPLOYDIR="/domains/WEBSUPPLY_PRD/servers/AdminServer/upload"
echo "Criando cópia de Segurança"
mv $DEPLOYDIR/$FILENAME $MYHOME/$FILENAME-$DATE
echo "Fazendo Deploy"
mv $MYHOME/$FILENAME $DEPLOYDIR/
