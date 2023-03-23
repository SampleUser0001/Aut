# sftp put/get自動化 サンプル

sftp のput/getをシェルスクリプトで実行する。  
-bオプションを使用する。

- [sftp put/get自動化 サンプル](#sftp-putget自動化-サンプル)
  - [前提](#前提)
    - [Server](#server)
    - [Client](#client)
  - [実行](#実行)
    - [put](#put)
      - [実行例](#実行例)
    - [get](#get)
      - [実行例](#実行例-1)


## 前提

1. sftpサーバが起動していること。
2. パスフレーズなしの公開鍵がサーバ側にあること。

### Server

- datas
    - put用。
- gettest
    - get用。

``` txt
[sftp_user@ip-172-31-14-225 ~]$ whoami
sftp_user
[sftp_user@ip-172-31-14-225 ~]$ pwd
/home/sftp_user
[sftp_user@ip-172-31-14-225 ~]$ tree .
.
├── datas
└── gettest
    ├── flag
    └── sample.txt

2 directories, 2 files
[sftp_user@ip-172-31-14-225 ~]$ 
```

### Client 

``` txt
$ tree .
.
├── add_testfile.sh
├── app.sh
├── backup
├── bat
├── datas
│   ├── file
│   ├── flag
│   └── testfile.txt
├── env
│   └── sftp_server.env
├── getdir
├── get_functions.sh
├── oat
│   └── put
├── oat.sh
├── put_functions.sh
├── README.md
└── test.sh

6 directories, 12 files
```

## 実行

### put

``` bash
# sftp_user=sftp_user
# sftp_host=172.31.14.225
# from=$(pwd)/datas
# to=datas
# flag_file_name=flag
# backup_dir=$(pwd)/backup

# fromはクライアント側、toはサーバ側のディレクトリ名。

sh app.sh put $sftp_user $sftp_host $from $to $flag_file_name $backup_dir
```

#### 実行例

``` bash
# クライアント側
$ dir datas
file  flag  testfile.txt
$ dir backup
（何も出力されない）

sftp_user=sftp_user
sftp_host=172.31.14.225
from=$(pwd)/datas
to=datas
flag_file_name=flag
backup_dir=$(pwd)/backup

sh app.sh put $sftp_user $sftp_host $from $to $flag_file_name $backup_dir

$ dir datas
（何も出力されない）

$ dir backup/20230323_224638/
file  testfile.txt
```

``` bash
# サーバ側
[sftp_user@ip-172-31-14-225 ~]$ dir datas/
file  flag  testfile.txt
```

### get

``` bash
# sftp_user=sftp_user
# sftp_host=172.31.14.225
# from=gettest
# to=$(pwd)/getdir
# flag_file_name=flag
# backup_dir=$(pwd)/backup

# fromはサーバ側、toはクライアント側のディレクトリ名。
# backupは未実装。

sh app.sh get sftp_user 172.31.14.225 gettest $(pwd)/getdir flag $(pwd)/backup
```

#### 実行例

``` bash
# クライアント側

$ dir getdir/
（何も表示されない）

sftp_user=sftp_user
sftp_host=172.31.14.225
from=gettest
to=$(pwd)/getdir
flag_file_name=flag
backup_dir=$(pwd)/backup

sh app.sh get sftp_user 172.31.14.225 gettest $(pwd)/getdir flag $(pwd)/backup

$ ls getdir/
flag  sample.txt
```

