#!/bin/bash

# Check if Flutter exists
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Installing Flutter..."
    # Clone Flutter with specific version tag
    git clone https://github.com/flutter/flutter.git -b 3.27.4
    export PATH="$PATH:`pwd`/flutter/bin"
else
    echo "Flutter already installed"
    flutter --version
fi

# Enable web and check setup
flutter config --enable-web
flutter doctor

# Build the project
flutter build web --release