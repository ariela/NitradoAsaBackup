@ECHO OFF

@REM ====1====+====2====+====3====+====4====+====5====+====6====+====7====+====8====+====9====+====0
@REM NITRADO ASA�T�[�o�[ �o�b�N�A�b�v�p�X�N���v�g
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �K�{�A�v��
@REM    WinSCP�ihttps://winscp.net/eng/docs/lang:jp�j
@REM ====1====+====2====+====3====+====4====+====5====+====6====+====7====+====8====+====9====+====0

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �ݒ���
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �z�X�g���iDashboard > FTP Credentials > Hostname �̒l�j
SET NITRADO_FTP_HOST=XXXXXXX.gamedata.io

@REM �|�[�g�ԍ��iDashboard > FTP Credentials > Port �̒l�j
SET NITRADO_FTP_PORT=21

@REM ���[�U���iDashboard > FTP Credentials > Username �̒l�j
SET NITRADO_FTP_USER=XXXXXXXX

@REM �p�X���[�h�iDashboard > FTP Credentials > Password �̒l�j
SET NITRADO_FTP_PASS=XXXXXXXX

@REM WINSCP�̔z�u�p�X
SET WINSCP_PATH="C:\Program Files (x86)\WinSCP\WinSCP.com"

@REM �o�b�N�A�b�v�쐬��t�H���_
SET BACKUP_PATH=%APPDATA%\NitradoAsaBackup

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �o�b�N�A�b�v��t�H���_���쐬����
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
mkdir "%BACKUP_PATH%\Config\WindowsServer"
mkdir "%BACKUP_PATH%\SavedArks"

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM FTP�ʐM�p�t�@�C���쐬����
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@ECHO open ftp://%NITRADO_FTP_USER%:%NITRADO_FTP_PASS%@%NITRADO_FTP_HOST%:%NITRADO_FTP_PORT% > ftpprocess.txt
@ECHO synchronize local "%BACKUP_PATH%\Config\WindowsServer" "/arksa/ShooterGame/Saved/Config/WindowsServer" >> ftpprocess.txt
@ECHO synchronize local "%BACKUP_PATH%\SavedArks" "/arksa/ShooterGame/Saved/SavedArks" >> ftpprocess.txt
@ECHO bye >> ftpprocess.txt

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �t�@�C���_�E�����[�h�������s
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
%WINSCP_PATH% /script=ftpprocess.txt

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �ŐV�t�@�C�� �o�b�N�A�b�v��
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
SET TIME2=%time: =0%
SET year=%date:~0,4%
SET month=%date:~5,2%
SET day=%date:~8,2%
SET hour=%TIME2:~0,2%
SET minute=%TIME2:~3,2%

7zr.exe a "%BACKUP_PATH%\TheIsland_WP-%year%%month%%day%-%hour%%minute%.7z" "%BACKUP_PATH%\SavedArks\TheIsland_WP\TheIsland_WP.ark" "%BACKUP_PATH%\SavedArks\TheIsland_WP\*.arkprofile" "%BACKUP_PATH%\SavedArks\TheIsland_WP\*.arktribe"

@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
@REM �ꎞ�t�@�C���폜
@REM ----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8----+----9----+----0
DEL /F ftpprocess.txt
