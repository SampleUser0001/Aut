#!/bin/bash

. ./put_functions.sh

suite() {
    suite_addTest create_sftp_put_bat_test
}

create_sftp_put_bat_test() {
    current_dir=$(cd $(dirname $0);pwd)
    batpath=`create_sftp_put_bat ${current_dir}/'datas' 'piyo' 'flag'`
    
    expect=`echo -e 'cd piyo
put ./testfile.txt ./testfile.txt
put ./file ./file
put ./flag ./flag
exit'`
    actural=`cat $batpath`

    assertEquals "$expect" "$actural"
    rm $batpath
}

. $SHUNIT2_HOME/shunit2
