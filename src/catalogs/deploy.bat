@echo off
SET V1C_PATH=D:\downloads\1cv8\8.3.27.1508\bin\1cv8.exe
SET BASE_DIR=D:\downloads\AI\ai-grd\db\CostManagementBase
SET CONFIG_DIR=D:\downloads\AI\ai-grd\src\catalogs\GeneratedConfig

echo 1. Создание пустой информационной базы в %BASE_DIR%...
if exist "%BASE_DIR%" rmdir /s /q "%BASE_DIR%"
"%V1C_PATH%" CREATEINFOBASE File="%BASE_DIR%" /Visible

echo 2. Загрузка конфигурации из файлов...
"%V1C_PATH%" DESIGNER /F "%BASE_DIR%" /LoadConfigFromFiles "%CONFIG_DIR%"

echo.
echo ========================================================
echo Успешно! База создана и конфигурация загружена.
echo ========================================================
pause