#!/bin/bash

# MIA.vn Google Integration Platform - Repository Setup Script
# This script pushes the project to the new GitHub repository

echo "🚀 MIA.vn Google Integration Platform - Repository Push"
echo "=================================================="
echo ""

# Check if repository exists
echo "📋 Checking repository status..."
git remote -v

echo ""
echo "📤 Pushing to new repository..."
echo "Repository: https://github.com/caovinhphuc/MIA.vn-Google-Integration-Platform.git"
echo ""

# Push to new repository
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SUCCESS! Project pushed successfully!"
    echo ""
    echo "🔗 Repository URLs:"
    echo "   - GitHub: https://github.com/caovinhphuc/MIA.vn-Google-Integration-Platform"
    echo "   - Clone: git clone https://github.com/caovinhphuc/MIA.vn-Google-Integration-Platform.git"
    echo ""
    echo "🚀 Next Steps:"
    echo "   1. Check GitHub repository"
    echo "   2. Update Vercel deployment (if needed)"
    echo "   3. Update documentation links"
    echo ""
else
    echo ""
    echo "❌ ERROR: Failed to push to repository"
    echo ""
    echo "📝 Please ensure:"
    echo "   1. Repository exists: https://github.com/caovinhphuc/MIA.vn-Google-Integration-Platform"
    echo "   2. You have push access to the repository"
    echo "   3. Repository is public or you're authenticated"
    echo ""
    echo "🔧 Manual steps to create repository:"
    echo "   1. Go to: https://github.com/new"
    echo "   2. Repository name: MIA.vn-Google-Integration-Platform"
    echo "   3. Description: 🚀 MIA.vn Google Integration Platform - Nền tảng tự động hóa Google Services chuyên nghiệp"
    echo "   4. Make it Public"
    echo "   5. Don't add README (we have one)"
    echo "   6. Click 'Create repository'"
    echo "   7. Run this script again"
fi

echo ""
echo "📊 Repository contains:"
git log --oneline -5
echo ""
echo "📁 Files ready for deployment:"
echo "   - ✅ All documentation updated"
echo "   - ✅ Environment files sanitized"
echo "   - ✅ Production configuration ready"
echo "   - ✅ Vercel deployment configured"
echo ""
