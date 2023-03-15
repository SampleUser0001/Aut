#!/bin/bash

sftp_put() {
    user=$1
    host=$2
    from=$3
    to=$4

    sftp_command=`create_sftp_put_bat $from $to`
    sftp -b $sftp_command -r ${user}@${host}
    rm $sftp_command
}

create_sftp_put_bat() {
    from=$1
    to=$2

    send_date=`date '+%Y%m%d_%H%M%S'`    
    format=`cat bat/format`
    bat_file_path='bat/batfile_'$send_date

    printf "${format}" ${to} ${from} > $bat_file_path
        
    echo $bat_file_path
}
