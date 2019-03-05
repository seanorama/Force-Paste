#!/bin/bash
APP_NAME="Force Paste.app"
INFO_PLIST="$APP_NAME/Contents/Info.plist"

rm -rf "$APP_NAME"
osacompile -o "$APP_NAME" -l JavaScript -x "main.scpt"
/usr/libexec/PlistBuddy -c "Add NSUIElement String 1" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Set CFBundleIconFile icon" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add CFBundleVersion String 101" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add CFBundleShortVersionString String sa-1.0.4" "$INFO_PLIST"
/usr/libexec/PlistBuddy -c "Add NSHumanReadableCopyright String '© 2019 https://github.com/superawesome/Force-Paste/'" "$INFO_PLIST"

rm -f "$APP_NAME/Contents/Resources/applet.icns"
cp "icon.icns" "$APP_NAME/Contents/Resources/"

if [ -f "Force-Paste.zip" ]; then
    rm -r "Force-Paste.zip"
fi

zip -r "Force-Paste.zip" "Force Paste.app"
