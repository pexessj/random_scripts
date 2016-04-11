#!/bin/bash
#
# This script performs the dump a MySQL database and sends this database to an S3 bucket AWS environment.
#
# Created by: eu@matheuscarino.com.br
#

DB_NAME=""
DB_USER=""
DB_PASSWORD=""
DB_HOST=""
MYSQL_DUMP=`which mysqldump`
DATE=`date +%Y-%m-%d`
DUMP_NAME=mysql-$DATE.sql
TAR=`which tar`
BUCKET_NAME=""
AWSCLI=`which aws`

$MYSQL_DUMP -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME > /tmp/$DUMP_NAME
$TAR -zcvf /tmp/$DUMP_NAME.tar.gz /tmp/$DUMP_NAME

$AWSCLI s3 cp /tmp/$DUMP_NAME.tar.gz s3://$BUCKET_NAME/mysql/
if [ $? -eq 0 ];
        then
                echo "$DATE Backup $DOWNLOADS successfully completed." >> /dados/logs/backup.log
                echo "BACKUP DEVINT-SAMBA $DATE successfully completed." | mail -s "DEVINT-SAMBA BKP '$DATE' OK" eu@matheuscarino.com.br
        else
                echo "$DATE Backup $DOWNLOADS not completed successfully." >> /dados/logs/backup.log
                echo "BACKUP DEVINT-SAMBA $DATE not completed successfully." | mail -s "DEVINT-SAMBA BKP '$DATE' FAIL" eu@matheuscarino.com.br
fi


rm -rf /tmp/$DUMP_NAME*
