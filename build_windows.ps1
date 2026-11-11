$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
py -3.12 -m venv .build-venv
$python = Join-Path $PSScriptRoot '.build-venv\Scripts\python.exe'
& $python -m pip install --upgrade pip
& $python -m pip install -r requirements.txt
& $python -m PyInstaller --noconfirm --clean --onefile --windowed --name 'Chaos Loss Aversion' --icon 'Images\Chaos Orb.ico' --add-data 'Images;Images' --add-data 'Audio Clips;Audio Clips' --add-data 'README.txt;.' --collect-all dxcam main.py
if ($LASTEXITCODE -ne 0) { throw 'PyInstaller build failed' }
New-Item -ItemType Directory -Force -Path 'release\CLA_1.0' | Out-Null
Copy-Item 'dist\Chaos Loss Aversion.exe' 'release\CLA_1.0\Chaos Loss Aversion.exe' -Force
Copy-Item 'README.txt' 'release\CLA_1.0\README.txt' -Force
Compress-Archive -Path 'release\CLA_1.0' -DestinationPath 'release\CLA_1.0.zip' -Force
Write-Host 'Created release\CLA_1.0.zip'
