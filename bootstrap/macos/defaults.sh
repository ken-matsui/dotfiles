#!/bin/bash
set -eu

# Ask to keep changes when closing documents
defaults write -g NSCloseAlwaysConfirmsChanges -bool true

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screen Saver never starts
defaults -currentHost write com.apple.screensaver idleTime -int 0

# Dock size
defaults write com.apple.dock tilesize -float 47
# Turn on Dock Magnification
defaults write com.apple.dock magnification -bool true
# Dock Magnification
defaults write com.apple.dock largesize -float 113
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# Launchpad icon size
defaults write com.apple.dock springboard-columns -int 10
defaults write com.apple.dock springboard-rows -int 8
defaults write com.apple.dock ResetLaunchPad -bool true

# Show Hard disks on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -int 1

# New Finder windows show...
defaults write com.apple.finder NewWindowTarget -string PfDo
defaults write com.apple.finder NewWindowTargetPath -string "file://~/Documents/"

# Do not show Recents on the sidebar
defaults write com.apple.finder ShowRecentTags -int 0

# Speed up dialog display and window resize speed
defaults write NSGlobalDomain NSWindowResizeTime -float 0.1

# Fastest Key Repeat
defaults write NSGlobalDomain KeyRepeat -int 2
# Shortest Delay Until Repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# ¥ key generates \ (backslash)
defaults write com.apple.inputmethod.Kotoeri JIMPrefCharacterForYenKey -int 1

# Show the battery percentage in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Configure screenshot
defaults write com.apple.screencapture name ScreenShot
defaults write com.apple.screencapture include-date -bool false
defaults write com.apple.screencapture location ~/Downloads
# Do not display thumbnail
defaults write com.apple.screencapture show-thumbnail -bool false

# Fastest Trackpad speed
defaults write com.apple.trackpad scaling -float 3

# Show volume on the menu bar
defaults write com.apple.menuextra.volume -bool true
defaults write com.apple.systemuiserver.plist menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"

# Show bluetooth on the menu bar
defaults write com.apple.menuextra.bluetooth -bool true
defaults write com.apple.systemuiserver.plist menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# Show hidden files on Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

#
# Siri
#
# Disable Ask Siri
defaults write com.apple.assistant.support.plist "Assistant Enabled" -bool false
# Hide Siri in menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false

#
# Security Privacy
#
# Ask for password
defaults write com.apple.screensaver askForPassword -bool true
# Ask for password immediately
defaults write com.apple.screensaver askForPasswordDelay -int 0

#
# Desktop
#
# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 85' ~/Library/Preferences/com.apple.finder.plist
# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist
# text size on the desktop
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 10' ~/Library/Preferences/com.apple.finder.plist

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

killall Dock
killall Finder
