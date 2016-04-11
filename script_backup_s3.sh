#!/bin/bash
#
# This script synchronizes some specific directories with an S3 bucket in the AWS environment.
#
# Created by: eu@matheuscarino.com.br
#
# More information: http://docs.aws.amazon.com/cli/latest/reference/s3/sync.html
#

BUCKET_NAME=""
AWS_CLI="/usr/local/aws/bin/aws"
DATE=`date +"%d-%m-%Y"`

## DIRECTORIES TO BACKUP
DIR1="/dados/"
DIR2="/backup/"
DIR3="/logs/"

## EXECUTION
for DIRS in $DIR1 $DIR2 $DIR3
do
$AWS_CLI s3 sync $DIRS s3://$BUCKET_NAME/$DIRS
done
if [ $? -eq 0 ];
	then
		echo "$DATE Backup successfully completed." >> /dados/logs/backup.log
		echo "$DATE BACKUP successfully completed." | mail -s "BKP $DATE OK" matheus.ramos@b2wdigital.com
	else
		echo "$DATE Backup not completed successfully." >> /dados/logs/backup.log
		echo "$DATE BACKUP not completed successfully." | mail -s "BKP $DATE FAIL" matheus.ramos@b2wdigital.com

fi
