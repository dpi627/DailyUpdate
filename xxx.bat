@echo off
chcp 65001
::/e /xo /r:1 /w:0 /tee /nfl
set SRC="\\twtpeoad002\SGS_WEB\OpenSSL"
:: �ؼи��| (�ƥ�����̡A�ؿ����s�b�S���Y)
set TAG="\\twtpeoad002\_backup\xxx"
set LOG="\\twtpeoad002\SGS_WEB\xxx.log"
set EXD="\\twtpeoad002\SGS_WEB\OpenSSL\Log" "\\twtpeoad002\SGS_WEB\OpenSSL\CodeTemp"

robocopy %SRC% %TAG% /e /xo /r:1 /w:0 /tee /nfl /log+:%LOG% /xd %EXD%
pause