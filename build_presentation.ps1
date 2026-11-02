# build_presentation.ps1
# Локальная сборка PDF (для проверки перед push)

$ErrorActionPreference = "Stop"

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error "Pandoc не найден. Установите: https://pandoc.org/installing.html"
    exit 1
}

Write-Host "== Генерация PRESENTATION.pdf ==" -ForegroundColor Cyan
pandoc PRESENTATION.md -o PRESENTATION.pdf `
    --pdf-engine=xelatex `
    -V mainfont="Times New Roman" `
    -V geometry:margin=1.5cm `
    --toc `
    --number-sections `
    --metadata title="Система управления затратами"

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] PDF создан: PRESENTATION.pdf" -ForegroundColor Green
} else {
    Write-Error "Ошибка при сборке PDF"
}
