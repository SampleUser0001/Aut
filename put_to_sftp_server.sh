#!/bin/bash

sftp_put() {
    user=$1
    host=$2
    from=$3
    to=$4

    expect -c "
    set timeout 5
    
    spawn sftp -r ${user}@${host}
    
    expect \"sftp>\"
    send \"cd ${to}\r\"

    expect \"sftp>\"
    send \"put ${from}\r\"
    
    expect \"sftp>\"
    send \"exit\"
    "

}

# testfile.txtに追記
./add_testfile.sh

# 環境ファイル取り込み
source ./env/sftp_server.env

# 送信日年月日_時分秒を取得
send_date=`date '+%Y%m%d_%H%M%S'`

# sftpでサーバにputする。
sftp_put ${sftp_server_user} ${sftp_server_host} './testfile.txt' ${sftp_server_dir}
