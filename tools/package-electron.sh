#!/bin/bash

set -euxo pipefail

# Clear out any files remaining from old builds
rm -rf .package

mkdir -p .package/dist/ || true

cp index.html .package
cp favicon.ico .package
cp -r electron/* .package
# steam_appid.txt would end up in the resource dir
rm .package/steam_appid.txt
cp -r dist .package

# Install electron sub-dependencies
cd electron
npm install
cd ..

BUILD_PLATFORM="${1:-"all"}"
# And finally build the app.
npm run electron:packager-$BUILD_PLATFORM

echo .build/* | xargs -n 1 cp electron/steam_appid.txt
