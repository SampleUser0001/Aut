#!/bin/bash

. ./functions.sh

suite() {
    suite_addTest create_sftp_put_bat_test
}

create_sftp_put_bat_test() {
    batpath=`create_sftp_put_bat 'hoge' 'piyo'`
    
    expect=`echo -e 'put -r hoge piyo\nexit\n'`
    actural=`cat $batpath`

    assertEquals "$expect" "$actural"
    rm $batpath
}

. $SHUNIT2_HOME/shunit2
