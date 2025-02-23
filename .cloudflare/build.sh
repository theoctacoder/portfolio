#!/bin/bash

# Clone Flutter with specific version tag
git clone https://github.com/flutter/flutter.git -b 3.27.4
export PATH="$PATH:`pwd`/flutter/bin"

# Enable web and check setup
flutter config --enable-web
flutter doctor

# Build the project
flutter build web --release