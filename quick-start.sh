#!/bin/bash

# 🚀 Quick Start Script for MIA.vn Google Integration Platform

echo "🚀 MIA.vn Google Integration Platform - Quick Start"
echo "================================================="

# Auto-setup everything and start development server
./start-project.sh quick

# If quick setup successful, start dev server
if [ $? -eq 0 ]; then
    echo ""
    echo "🎯 Starting development server..."
    ./start-project.sh dev
fi
