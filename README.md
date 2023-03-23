# sftp put自動化 サンプル

sftp のputをシェルスクリプトで実行する。  
-bオプションを使用する。実行するbatは```bat/format```から生成する。

## 前提

1. sftpサーバが起動していること。
2. パスフレーズなしの公開鍵がサーバ側にあること。

## 実行

``` bash
sh app.sh put sftp_user 172.31.14.225 $(pwd)/datas datas flag
```
