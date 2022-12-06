@echo off
chcp 65001
::/e /xo /r:1 /w:0 /tee /nfl
set SRC="\\twtpeoad002\SGS_WEB\OpenSSL"
:: 目標路徑 (備份到哪裡，目錄不存在沒關係)
set TAG="\\twtpeoad002\_backup\xxx"
set LOG="\\twtpeoad002\SGS_WEB\xxx.log"
set EXD="\\twtpeoad002\SGS_WEB\OpenSSL\Log" "\\twtpeoad002\SGS_WEB\OpenSSL\CodeTemp"

robocopy %SRC% %TAG% /e /xo /r:1 /w:0 /tee /nfl /log+:%LOG% /xd %EXD%
pause