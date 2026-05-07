@echo off
cd /d %~dp0artifacts\edu-platform
set PORT=5173
set BASE_PATH=/
echo Starting frontend on port %PORT%...
echo Frontend will be available at http://localhost:%PORT%/
pnpm run dev