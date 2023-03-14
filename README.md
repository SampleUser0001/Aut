# sftp put自動化 サンプル

sftp のputをシェルスクリプトで実行する。  
expectを使う。

## 前提

1. sftpサーバが起動していること。
2. パスフレーズなしの公開鍵がサーバ側にあること。

## 実行

``` bash 
sh put_to_sftp_server.sh
```