#!/bin/bash

# 環境ファイル取り込み
# source ./env/sftp_server.env

operation=$1
sftp_user=$2
sftp_host=$3
from_data_dir=$4
to_data_dir=$5
flag_file_name=$6

# 送受信年月日_時分秒を取得
send_date=`date '+%Y%m%d_%H%M%S'`

# put
if [ $operation = "put" ]; then
    # testfile.txtに追記
    ./add_testfile.sh
    . ./put_functions.sh

elif [ $operation = "get" ]; then
    # get
    echo 'get'
else
    # 
    echo 'not found operation'
fi

