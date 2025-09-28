#!/bin/bash

# 🚀 MIA.vn Google Integration Platform - Startup Script
# This script helps you quickly start the project in different modes

echo "🚀 MIA.vn Google Integration Platform"
echo "====================================="
echo ""

# Function to check if Node.js is available
check_node() {
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js not found!"
        echo "📥 Installing Node.js via nvm..."

        # Load nvm if available
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        if command -v nvm &> /dev/null; then
            nvm install --lts
            nvm use --lts
        else
            echo "⚠️  Please install Node.js manually: https://nodejs.org/"
            exit 1
        fi
    fi

    echo "✅ Node.js $(node --version) ready"
    echo "✅ npm $(npm --version) ready"
}

# Function to install dependencies
install_deps() {
    echo "📦 Checking dependencies..."

    if [ ! -d "node_modules" ] || [ ! -f "package-lock.json" ]; then
        echo "📥 Installing dependencies..."
        npm install

        if [ $? -eq 0 ]; then
            echo "✅ Dependencies installed successfully!"
        else
            echo "❌ Failed to install dependencies!"
            exit 1
        fi
    else
        echo "✅ Dependencies already installed"
    fi
}

# Function to check environment file
check_env() {
    if [ ! -f ".env" ]; then
        echo "⚠️  Environment file not found!"
        echo "📄 Creating .env from template..."

        if [ -f "env.example" ]; then
            cp env.example .env
            echo "✅ .env file created from env.example"
            echo "📝 Please edit .env file with your actual values:"
            echo "   - Google Service Account credentials"
            echo "   - SendGrid API key"
            echo "   - Telegram Bot token"
        else
            echo "❌ No env.example found!"
        fi
    else
        echo "✅ Environment file exists"
    fi
}

# Function to start development server
start_dev() {
    echo "🔧 Starting development server..."
    echo "📱 Access: http://localhost:3000"
    echo "🔐 Login: admin/admin123 or user/user123"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo "================================"
    npm start
}

# Function to start production build
start_prod() {
    echo "🏗️  Building for production..."
    npm run build

    if [ $? -eq 0 ]; then
        echo "✅ Build completed successfully!"
        echo "📁 Build files in: ./build/"
        echo ""
        echo "🚀 You can now deploy using:"
        echo "   - ./deploy-production.sh"
        echo "   - vercel --prod"
        echo "   - Or serve build folder with any static server"
    else
        echo "❌ Build failed!"
        exit 1
    fi
}

# Function to run tests
run_tests() {
    echo "🧪 Running tests..."
    npm test -- --coverage --watchAll=false

    if [ $? -eq 0 ]; then
        echo "✅ All tests passed!"
    else
        echo "❌ Some tests failed!"
        exit 1
    fi
}

# Function to run health check
health_check() {
    echo "🏥 Running health check..."

    if [ -f "scripts/health-check.js" ]; then
        node scripts/health-check.js
    else
        echo "⚠️  Health check script not found"
        echo "📊 Checking basic project structure..."

        # Check important files
        files=("package.json" "src/App.jsx" "public/index.html")
        for file in "${files[@]}"; do
            if [ -f "$file" ]; then
                echo "✅ $file exists"
            else
                echo "❌ $file missing"
            fi
        done
    fi
}

# Main menu
show_menu() {
    echo "🎯 What would you like to do?"
    echo ""
    echo "1) 🔧 Start Development Server"
    echo "2) 🏗️  Build for Production"
    echo "3) 🧪 Run Tests"
    echo "4) 🏥 Health Check"
    echo "5) 📊 System Info"
    echo "6) 🛠️  Setup Environment"
    echo "7) 🚀 Quick Start (Full Setup)"
    echo "8) ❌ Exit"
    echo ""
    read -p "Enter your choice (1-8): " choice

    case $choice in
        1)
            check_node
            install_deps
            check_env
            start_dev
            ;;
        2)
            check_node
            install_deps
            start_prod
            ;;
        3)
            check_node
            install_deps
            run_tests
            ;;
        4)
            health_check
            ;;
        5)
            echo "📊 System Information:"
            echo "   - OS: $(uname -s)"
            echo "   - PWD: $(pwd)"
            echo "   - User: $(whoami)"
            if command -v node &> /dev/null; then
                echo "   - Node.js: $(node --version)"
                echo "   - npm: $(npm --version)"
            fi
            if command -v git &> /dev/null; then
                echo "   - Git: $(git --version)"
                echo "   - Repository: $(git remote get-url origin 2>/dev/null || echo 'Not a git repository')"
            fi
            ;;
        6)
            check_node
            install_deps
            check_env
            echo "✅ Environment setup completed!"
            ;;
        7)
            echo "🚀 Quick Start - Full Setup"
            echo "=========================="
            check_node
            install_deps
            check_env
            health_check
            echo ""
            echo "✅ Project is ready!"
            echo "🔧 Starting development server..."
            start_dev
            ;;
        8)
            echo "👋 Goodbye!"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice! Please select 1-8"
            show_menu
            ;;
    esac
}

# Check if running with arguments
if [ $# -eq 0 ]; then
    # Interactive mode
    show_menu
else
    # Command line mode
    case "$1" in
        "dev"|"start"|"development")
            check_node
            install_deps
            check_env
            start_dev
            ;;
        "build"|"prod"|"production")
            check_node
            install_deps
            start_prod
            ;;
        "test"|"tests")
            check_node
            install_deps
            run_tests
            ;;
        "health"|"check")
            health_check
            ;;
        "setup"|"install")
            check_node
            install_deps
            check_env
            echo "✅ Setup completed!"
            ;;
        "quick"|"all")
            check_node
            install_deps
            check_env
            health_check
            echo "✅ Quick setup completed!"
            ;;
        *)
            echo "Usage: $0 [command]"
            echo ""
            echo "Available commands:"
            echo "  dev, start, development  - Start development server"
            echo "  build, prod, production  - Build for production"
            echo "  test, tests             - Run tests"
            echo "  health, check           - Run health check"
            echo "  setup, install          - Setup environment"
            echo "  quick, all              - Full setup"
            echo ""
            echo "Run without arguments for interactive mode"
            ;;
    esac
fi
