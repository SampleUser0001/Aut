#!/bin/bash

# sftp putする。
# 引数
#   1. sftpサーバユーザ
#   2. sftpサーバホスト名orIP
#   3. 送信元ディレクトリ
#   4. 送信先ディレクトリ
#   5. フラグファイル
sftp_put() {
    user=$1
    host=$2
    from=$3
    to=$4
    flag_filename=$5

    sftp_command=`create_sftp_put_bat $from $to $flag_filename`
    cd ${from}
    sftp -b $sftp_command -r ${user}@${host}
    rm $sftp_command
}

# bat/formatファイルを元にputコマンドを持っているファイルを生成する。
# 引数
#   1. 送信元ディレクトリ
#   2. 送信先ディレクトリ
#   3. フラグファイルファイル名
# 戻り値
#   batファイルパス
create_sftp_put_bat() {
    from=$1
    to=$2
    flag_filename=$3

    current_dir=$(cd $(dirname $0);pwd)
    send_date=`date '+%Y%m%d_%H%M%S'` 
    bat_file_path=$current_dir/'bat/batfile_'$send_date

    cd ${from}

    echo -e "cd ${to}" >> $bat_file_path

    # サーバ側にディレクトリ作成
    # for d in $(find . -type d ) ; do
    #    printf "mkdir ${d}\n" >> $bat_file_path
    # done

    # サーバにファイルput
    for f in $(find . -type f | grep -v "${flag_filename}$" ) ; do
        printf "put ${f} ${f}\n" >> $bat_file_path
    done

    # フラグファイル送信
    flag_filepath=$(find . -type f | grep "${flag_filename}$" )
    printf "put ${flag_filepath} ${flag_filepath}\n" >> $bat_file_path
    echo -e 'exit' >> $bat_file_path
        
    echo $bat_file_path
}
