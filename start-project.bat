@echo off
:: 🚀 MIA.vn Google Integration Platform - Windows Startup Script

echo 🚀 MIA.vn Google Integration Platform
echo =====================================
echo.

:: Check if Node.js is installed
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Node.js not found!
    echo 📥 Please install Node.js from: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo ✅ Node.js found:
node --version
echo ✅ npm found:
npm --version
echo.

:: Check if dependencies are installed
if not exist "node_modules" (
    echo 📦 Installing dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo ❌ Failed to install dependencies!
        pause
        exit /b 1
    )
    echo ✅ Dependencies installed successfully!
) else (
    echo ✅ Dependencies already installed
)

:: Check environment file
if not exist ".env" (
    echo ⚠️  Environment file not found!
    if exist "env.example" (
        copy env.example .env
        echo ✅ .env file created from template
        echo 📝 Please edit .env file with your actual values
    ) else (
        echo ❌ No env.example found!
    )
) else (
    echo ✅ Environment file exists
)

echo.
echo 🎯 Choose an option:
echo 1. Start Development Server
echo 2. Build for Production
echo 3. Run Tests
echo 4. Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" (
    echo 🔧 Starting development server...
    echo 📱 Access: http://localhost:3000
    echo 🔐 Login: admin/admin123 or user/user123
    echo.
    echo Press Ctrl+C to stop the server
    call npm start
) else if "%choice%"=="2" (
    echo 🏗️  Building for production...
    call npm run build
    if %errorlevel% equ 0 (
        echo ✅ Build completed successfully!
        echo 📁 Build files in: .\build\
    )
) else if "%choice%"=="3" (
    echo 🧪 Running tests...
    call npm test -- --coverage --watchAll=false
) else if "%choice%"=="4" (
    echo 👋 Goodbye!
    exit /b 0
) else (
    echo ❌ Invalid choice!
    goto :start
)

pause
