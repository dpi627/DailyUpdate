![](https://img.shields.io/badge/SGS-OAD-orange) 
![](https://img.shields.io/badge/proj-Daily--Update-purple)
![](https://img.shields.io/badge/ChatGPT-412991?logo=openai)
![](https://img.shields.io/badge/Claude-191919?logo=anthropic) 
![](https://img.shields.io/badge/GitHub_Copilot-555?logo=githubcopilot)

# SGS.OAD.DailyUpdate

- 將 LIMS 日常更新作業標準化，開發批次檔加速執行
- 指令盡可能符合 Windows 原生執行環境，減少執行異常
- 專案採分層設計，進行基本關注點分離，並符合部分 SOLID 原則
- 所有批次檔皆可獨立執行，方便進行單元開發、測試
- 包含多種歷程記錄方式 (建議安裝 `curl` 獲得完整體驗)

# 🗃️專案架構

```c
📁 Batchs   //各步驟獨立批次檔
📁 Configs  //各種設定檔 (ini)
📁 Utils    //通用函式庫
📄 backup_server.bat    //備份測試機
📄 daily_update.bat     //每日更新
📄 weekly_update.bat    //每週更新
```
- `📁Batches` 內包含所有主要步驟之批次檔 `*.bat`