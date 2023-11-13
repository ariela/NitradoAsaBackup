## WinSCPのインストール
このバッチではWinSCPを使用しているため、インストールを行います。

https://winscp.net/eng/download.php を開き、 `DOWNLOAD WINSCP X.Y.Z (XX MB)`となっているボタンをクリックするとインストーラーがダウンロード出来るので、インストールを行ってください。

## バッチファイルのインストール

1. ダウンロードした `NitradoAsaBackup.zip` を右クリックし、 `すべて展開` で解凍を行う。

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/001.png?raw=true)
![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/002.png?raw=true)

2. 解凍して出来たディレクトリ `NitradoAsaBackup` を 任意の場所に移動する。
    - 以下例では `C:\NitradoAsaBackup` に配置したものとして記載する。

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/003.png?raw=true)

3. `backup.cmd` を開き、設定を行う
    - NITRADO_FTP_HOST: `NITRADOのDashboard > FTP Credentials > Hostnameの値を設定`
    - NITRADO_FTP_PORT: `NITRADOのDashboard > FTP Credentials > Port の値を設定`
    - NITRADO_FTP_USER: `NITRADOのDashboard > FTP Credentials > Username の値を設定`
    - NITRADO_FTP_PASS: `NITRADOのDashboard > FTP Credentials > Password の値を設定`
    - WINSCP_PATH: `WinSCPをインストールしたディレクトリにあるWinSCP.comのパスを設定`
    - BACKUP_PATH: `バックアップファイル保存先ディレクトリを設定`

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/004.png?raw=true)


## スケジュール登録

1. スタートメニューの検索から `taskschd.msc` を検索し、実行する。

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/005.png?raw=true)

2. メニューの `操作 → タスクの作成` をクリックする。（以下設定値は変更箇所のみ記載する）

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/006.png?raw=true)

3. 全般タブの設定を行う
    - 名前: `任意の名前` （例: NITRADO ASA バックアップ）

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/007.png?raw=true)

4. トリガータブの設定を行う
    - 新規ボタンをクリック
    - タスクの開始: `スケジュールに従う`
    - 設定: `1回`
    - 繰り返し間隔: `15分` （※NITRADOの設定 Auto-save interval のn倍数を推奨）
    - 継続時間: `無制限`
  
![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/007.png?raw=true)
![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/008.png?raw=true)

5. 操作タブの設定を行う
    - 新規ボタンをクリック
    - 操作: `プログラムの開始`
    - 設定:
        - プログラム/スクリプト: `配置パス\backup.vbs` （例: C:\NitradoAsaBackup\backup.vbs）
        - 開始（オプション）(T): `配置パス` （例: C:\NitradoAsaBackup）

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/009.png?raw=true)

6. 条件タブの設定を行う
    - 電源
        - コンピュータをAC電源で使用している場合のみタスクを開始する: `チェックをOff`
    - ネットワーク
        - 次のネットワーク接続が可能な場合のみタスクを開始する: `チェックをOn`
        - `任意の接続`

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/010.png?raw=true)

8. 設定タブの設定を行う
    - タスクを停止するまでの時間: `チェックをOff`
    - 要求時に実行中のタスクが終了しない場合、タスクを強制的に停止する: `チェックをOff`

![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/011.png?raw=true)

## 出力ファイル説明
- `%BACKUP_PATH%\Config` ディレクトリ
    - 設定ファイルのバックアップ
    - ![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/012.png?raw=true)
- `%BACKUP_PATH%\SavedArks` ディレクトリ
    - マップデータ等のバックアップ
    - ![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/013.png?raw=true)
- `%BACKUP_PATH%\TheIsland_WP-YYYYMMDD-HHMM.7z` ファイル
    - バックアップ実施時点の最新マップデータ等ファイルを7z形式で圧縮したファイル
    - ![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/014.png?raw=true)
    - ![](https://github.com/ariela/NitradoAsaBackup/blob/main/images/015.png?raw=true)

## NITRADOにバックアップを戻す場合
- NITRADOのサーバーを停止する
- NITRADOのサーバーにFTPでアクセスをする
    - インストールしたWinSCPを利用可能
    - 接続先情報は `Dashboard → FTP Credentials` の値を設定する
- `/arksa/ShooterGame/Saved/SavedArks/TheIsland_WP` に戻したい時間の7zファイルを解凍して出てきたファイル（*.arkprofile/*.arktribe/TheIsland_WP.ark）を上書きアップデートする
- NITRADOのサーバーを開始する

