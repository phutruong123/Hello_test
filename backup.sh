  GNU nano 5.4                                                                              backup.sh
#! /bin/bash
### Script backup configuration of Check_MK then copy to nsvn05
# Explain:
### Last-Update: 21.06.22
### Echo time
echo "---------------------------------------------------------"
echo "--- Starting Check_MK script backup ---"
echo "---------------------------------------------------------"
MAIL_LOG=/root/BackupScript/mail_log.txt
mv /root/BackupScript/mail_log.txt /tmp/
echo "To: phu.truong@elca.vn" >> $MAIL_LOG
echo "Subject: [ITSVN][NW] Report from Check_MK backup script - $(date)" >> $MAIL_LOG
echo "From: no_reply_sw_backup@elca.vn" >> $MAIL_LOG
echo "Testing cronjob for backup script!!!"
echo "This report is generate from Check_MK backup script on $(date)" >> $MAIL_LOG
echo >> $MAIL_LOG
# Function 1: Copy backup file to nsvn05
echo "----------------------------------------------"
echo "Task 1.Copy backup file to nsvn05" >> $MAIL_LOG
BACKUP_DATE="$(date +%Y%m%d)"
DIR="/tmp/Check_MK-vmmonitor+vn-monitoring-ptta2-complete/"${BACKUP_DATE}
if [ -d "${DIR}" ]; then
   cd /mnt/cfg_checkmk_bk/
   rm -rf ${BACKUP_DATE}
   mkdir ${BACKUP_DATE}
   cp ${DIR}/* /mnt/cfg_checkmk_bk/${BACKUP_DATE}/ >> $MAIL_LOG
else
   echo "Error: The backup directory - ${DIR} not found. There are nothing to backup to nsvn05." >> $MAIL_LOG
   exit 1
fi
echo "Copy Check_MK backup files to /nsvn05/cfg_checkmk_bk/${BACKUP_DATE}......Done" >> $MAIL_LOG
echo
# Function 2: Send mail report
echo "----------------------------------------------"
echo "Task 2: Sending Check_mk backup log email......" >> $MAIL_LOG
#/root/BackupScript/sendmail.sh
echo
echo "All done!!!"
echo
echo "----------------------------------------------"
# DOne
echo "GoodBye. Please check your logs!!!"
cat $MAIL_LOG | /usr/sbin/sendmail phu.truong@elca.vn
exit 0