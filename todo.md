# LIMS 2.0 Daily Update Todo List

> 指令說明後的小括號 ( ) 內為可用參數，%1表示第一個，必須依照順序輸入
> 可用參數內的中括號 [ ] 內為選填參數，不輸入會詢問或使用預設值，不影響執行
> 參數值如以斜線 / 隔開，表示可輸入的數值，必填參數請勿輸入例外值

- [ ] 進入指令根目錄

  ```bash
  cd C:\dev\DailyUpdate
  ```

- [ ] 遠端備份 TWTPEOAD001/002 (%1=1/2, [%2=yyyymmdd, %3=y])

  ```bash
  .\server_backup.bat 1
  ```

  ```bash
  .\server_backup.bat 2
  ```

- [ ] Close Visual Studio

- [ ] 執行以下指令，可逐步完成後續步驟 ([%=yyyymmdd, %2=1/2/3/4/5, %3=y])

  ```bash
  .\all_in_one.bat
  ```

- [ ] (1) 刪除前一次備份暫存檔

- [ ] (2) SVN Update [CODE] and [RELEASE_CODE]

- [ ] SVN Log 比對，匯出檔案 to [EXPORT]

- [ ] (3) 複製 [EXPORT] to [RELEASE_CODE]

- [ ] 檢查 File Add / Delete

- [ ] (4) [RELEASE_CODE] build and deploy to [PUBLISH]

- [ ] (5) 複製 [PUBLISH] to TWFS007

- [ ] SQL 檢查、備份與執行

- [ ] 其他例外處理 (Web.config, ClientAPI)

- [ ] 複製 [PUBLISH] to TWTPEOAD001/002，測試連線、F12、登入 (%1=1/2, [%2=yyyymmdd, %3=y])

  ```bash
  .\server_update_and_test.bat 1
  ```

  ```bash
  .\server_update_and_test.bat 2
  ```

- [ ] SVN commit [RELEASE_CODE]

- [ ] TEAMS 群組通報已更新