#!/bin/bash
set -euo pipefail

# Use the same Flutter version the project pins with FVM (.fvmrc).
FLUTTER_VERSION=$(sed -nE 's/.*"flutter": *"([^"]+)".*/\1/p' .fvmrc)
FLUTTER_VERSION=${FLUTTER_VERSION:-3.47.7}

# Check if Flutter exists
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Installing Flutter $FLUTTER_VERSION..."
    git clone --depth 1 https://github.com/flutter/flutter.git -b "$FLUTTER_VERSION"
    export PATH="$PATH:`pwd`/flutter/bin"
else
    echo "Flutter already installed"
fi
flutter --version

# Enable web
flutter config --enable-web

APP_VERSION=$(grep -m 1 '^version:' pubspec.yaml | awk '{print $2}' | cut -d'+' -f1)

INDEX_HTML="web/index.html"

# Cache-bust the bootstrap script (GNU sed on the build image: no "" after -i).
sed -i "s/<script src=\"flutter_bootstrap.js\"/<script src=\"flutter_bootstrap.js?v=${APP_VERSION}\"/" "$INDEX_HTML"

# Build the project
flutter build web --release
