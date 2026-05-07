# Edu-Flow Project Run Script (PowerShell)
# This script starts all services needed for the Edu-Flow project offline

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Edu-Flow Project Starter" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if pnpm is installed
Write-Host "Checking for pnpm installation..." -ForegroundColor Yellow
$pnpmCheck = npm list -g pnpm 2>$null
if (-not $pnpmCheck) {
    Write-Host "Installing pnpm globally..." -ForegroundColor Yellow
    npm install -g pnpm
}
Write-Host "✓ pnpm is available" -ForegroundColor Green
Write-Host ""

# Install dependencies
Write-Host "Installing project dependencies..." -ForegroundColor Yellow
Write-Host "Running: pnpm install" -ForegroundColor Gray
pnpm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Failed to install dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Dependencies installed successfully" -ForegroundColor Green
Write-Host ""

# Start services
Write-Host "Starting services..." -ForegroundColor Yellow
Write-Host ""

# Build the project
Write-Host "Building project..." -ForegroundColor Cyan
pnpm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Build failed" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Build completed" -ForegroundColor Green
Write-Host ""

# Start API Server
Write-Host "Starting API Server..." -ForegroundColor Cyan
Write-Host "API will run on: http://localhost:3000" -ForegroundColor Gray
$env:PORT = "3000"
$apiProcess = Start-Process -PassThru -NoNewWindow -WorkingDirectory ".\artifacts\api-server" `
    -FilePath "cmd.exe" `
    -ArgumentList "/c set PORT=3000 && pnpm run dev"

Start-Sleep -Seconds 3

# Start Frontend
Write-Host ""
Write-Host "Starting Frontend (Edu Platform)..." -ForegroundColor Cyan
Write-Host "Frontend will run on: http://localhost:5173" -ForegroundColor Gray
$env:PORT = "5173"
$env:BASE_PATH = "/"
$frontendProcess = Start-Process -PassThru -NoNewWindow -WorkingDirectory ".\artifacts\edu-platform" `
    -FilePath "cmd.exe" `
    -ArgumentList "/c set PORT=5173 && set BASE_PATH=/ && pnpm run dev"

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "All services started successfully!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Access your application at: http://localhost:5173" -ForegroundColor Cyan
Write-Host "API Server: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop all services" -ForegroundColor Yellow
Write-Host ""

# Keep the script running
while ($true) {
    Start-Sleep -Seconds 1
}
