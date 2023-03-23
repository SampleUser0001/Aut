#!/bin/bash

current_dir=$(cd $(dirname $0);pwd)
cd datas
sftp -b ${current_dir}/oat/put 'sftp_user'@'172.31.14.225'

