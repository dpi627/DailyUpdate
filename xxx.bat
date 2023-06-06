@echo off

for /l %%x in (1, 1, 50) do (
   echo %%x
   copy C:\dev\_tmp\src\L\sampleL.docx C:\dev\_tmp\src\L\sampleL_%%x.docx
   copy C:\dev\_tmp\src\P\sampleP.docx C:\dev\_tmp\src\P\sampleP_%%x.docx
)

pause
