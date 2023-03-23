#!/bin/bash

# sftp putする。
# 引数
#   1. sftpサーバユーザ
#   2. sftpサーバホスト名orIP
#   3. 送信元ディレクトリ
#   4. 送信先ディレクトリ
#   5. フラグファイル
sftp_get() {
    user=$1
    host=$2
    from=$3
    to=$4
    flag_filename=$5
    
    # フラグファイルを最後に取得することができないため、一度/tmp配下でgetする。
    tmp_dir=`create_tmp_dir`
    sftp_command=`create_sftp_get_bat $from $tmp_dir $flag_filename`

    sftp -b $sftp_command -r ${user}@${host}

    rm $sftp_command
    
    # 本当の${to}にコピーする。
    for f in $(find $tmp_dir -type f | grep -v "${flag_filename}$" ) ; do
        mv $f $to/
    done
    mv $tmp_dir/$flag_filename $to/
    
    rmdir $tmp_dir
}

# bat/formatファイルを元にputコマンドを持っているファイルを生成する。
# 引数
#   1. 送信元ディレクトリ
#   2. 送信先ディレクトリ
#   3. フラグファイルファイル名
# 戻り値
#   batファイルパス
create_sftp_get_bat() {
    from=$1
    to=$2

    current_dir=$(cd $(dirname $0);pwd)
    receive_date=`date '+%Y%m%d_%H%M%S'` 
    bat_file_path=$current_dir/'bat/batfile_'$receive_date

    echo -e "cd ${from}" >> $bat_file_path
    echo -e "get -r . ${to}" >> $bat_file_path
    echo -e 'exit' >> $bat_file_path
        
    echo $bat_file_path
}

# /tmp配下にディレクトリを作成する。
# 作成したディレクトリのパスを返す。
create_tmp_dir() {
    current_date=`date '+%Y%m%d_%H%M%S'` 
    random_dir_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
    
    dir_name="/tmp/"$current_date"_"$random_dir_name
    mkdir $dir_name
    echo $dir_name
}