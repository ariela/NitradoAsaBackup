@ECHO OFF

@REM ====1====+====2====+====3====+====4====+====5====+====6====+====7====+====8====+====9====+====0
@REM NITRADO ASAサーバー バックアップ用スクリプト
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM 必須アプリ
@REM    WinSCP（https://winscp.net/eng/docs/lang:jp）
@REM ====1====+====2====+====3====+====4====+====5====+====6====+====7====+====8====+====9====+====0

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM 設定情報
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM ホスト名（Dashboard > FTP Credentials > Hostname の値）
SET NITRADO_FTP_HOST=XXXXXXX.gamedata.io

@REM ポート番号（Dashboard > FTP Credentials > Port の値）
SET NITRADO_FTP_PORT=21

@REM ユーザ名（Dashboard > FTP Credentials > Username の値）
SET NITRADO_FTP_USER=XXXXXXXX

@REM パスワード（Dashboard > FTP Credentials > Password の値）
SET NITRADO_FTP_PASS=XXXXXXXX

@REM WINSCPの配置パス
SET WINSCP_PATH="C:\Program Files (x86)\WinSCP\WinSCP.com"

@REM バックアップ作成先フォルダ
SET BACKUP_PATH=%APPDATA%\NitradoAsaBackup

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM バックアップ先フォルダを作成する
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
mkdir "%BACKUP_PATH%\Config\WindowsServer"
mkdir "%BACKUP_PATH%\SavedArks"

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM FTP通信用ファイル作成処理
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@ECHO open ftp://%NITRADO_FTP_USER%:%NITRADO_FTP_PASS%@%NITRADO_FTP_HOST%:%NITRADO_FTP_PORT% > ftpprocess.txt
@ECHO synchronize local "%BACKUP_PATH%\Config\WindowsServer" "/arksa/ShooterGame/Saved/Config/WindowsServer" >> ftpprocess.txt
@ECHO synchronize local "%BACKUP_PATH%\SavedArks" "/arksa/ShooterGame/Saved/SavedArks" >> ftpprocess.txt
@ECHO bye >> ftpprocess.txt

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM ファイルダウンロード処理実行
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
%WINSCP_PATH% /script=ftpprocess.txt

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM 最新ファイル バックアップ化
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
SET TIME2=%time: =0%
SET year=%date:~0,4%
SET month=%date:~5,2%
SET day=%date:~8,2%
SET hour=%TIME2:~0,2%
SET minute=%TIME2:~3,2%

7zr.exe a "%BACKUP_PATH%\TheIsland_WP-%year%%month%%day%-%hour%%minute%.7z" "%BACKUP_PATH%\SavedArks\TheIsland_WP\TheIsland_WP.ark" "%BACKUP_PATH%\SavedArks\TheIsland_WP\*.arkprofile" "%BACKUP_PATH%\SavedArks\TheIsland_WP\*.arktribe"

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM 一時ファイル削除
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
DEL /F ftpprocess.txt
