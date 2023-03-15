#!/bin/bash

. ./functions.sh

# testfile.txtに追記
./add_testfile.sh

# 環境ファイル取り込み
source ./env/sftp_server.env

# 送信日年月日_時分秒を取得
send_date=`date '+%Y%m%d_%H%M%S'`

# sftpでサーバにputする。
sftp_put ${sftp_server_user} ${sftp_server_host} './datas' ${sftp_server_dir}
