![](https://img.shields.io/badge/SGS-OAD-orange) 
![](https://img.shields.io/badge/proj-Daily--Update-purple)
![](https://img.shields.io/badge/ChatGPT-412991?logo=openai)
![](https://img.shields.io/badge/Claude-191919?logo=anthropic) 
![](https://img.shields.io/badge/GitHub_Copilot-555?logo=githubcopilot)

# SGS.OAD.DailyUpdate

- 將 LIMS 日常更新作業標準化，開發批次檔節省時間
- 指令盡可能符合 Windows 原生執行環境，減少執行異常
- 專案採分層設計，進行基本關注點分離，並符合部分 SOLID 原則
- 所有批次檔皆可獨立執行，方便進行單元開發、測試
- 包含多種歷程記錄方式 (建議安裝 `curl` 獲得完整體驗)

# 🗃️專案架構

```c
📁 Batches  //各步驟獨立批次檔
📁 Configs  //各種設定檔 (ini)
📁 Utils    //通用函式庫
📁 Logs     //歷程記錄 (執行後生成，不納入版控)
📄 backup_server.bat    //備份測試機
📄 daily_update.bat     //每日更新
📄 weekly_update.bat    //每週更新
```
- `📁Batches` 包含核心步驟批次檔 `*.bat`，皆可獨立執行、測試
- `📁Configs` 包含所有 `*.ini` 設定檔，依照屬性拆分，方便管理
- `📁Utils` 包含多個通用函式 `*.bat`，皆可獨立執行、測試
- `📄backup_server.bat` 備份伺服器資料 (可考慮用分支取代)
- `📄daily_update.bat` 每日更新主程序，拉取測試分支 `uat` 後更新測試機
- `📄weekly_update.bat` 每周更新主程序，拉取預設分支 `main` 後發布更新檔

>🚨注意 `📁Configs` 之中的 `📄personal` 必須修改為個人電腦設定

# 作業流程

- 備份測試機
- 執行主要流程
- 更新測試機
- 測試連線與登入

# 📄主程式 `daily_update.bat` 說明