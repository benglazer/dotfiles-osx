#!/bin/bash

### Install and update homebrew.

echo "installing and updating homebrew..."

# Check for Homebrew, installing it if we don't have it.
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes.
brew update


### Now, update unix utilities that come with OS X

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Update PATH to use new binaries.
echo PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH >> ~/.bash_profile


### Optionally, install other binaries.

binaries=(
  # ffmpeg
  # sshfs
  # trash
  # node
  tree
  git
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup

### Install OS X apps via homebrew cask.

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

apps=(
  #1password  # probably have to install manually due to issues w/ chrome
  dropbox
  evernote
  firefox
  flux
  google-chrome
  iterm2
  sizeup
  skype
  sublime-text3
  transmission
  vlc
)

# Install apps to /Applications (default is /Users/$user/Applications).
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# SizeUp: Start at login
defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true
# SizeUp: Don’t show preferences window on next start
defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false

# Transmission: Use `~/Downloads/.torrents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/.torrents"
# Transmission: Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false
# Transmission: Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
# Transmission: Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Transmission: Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false


### Install fonts via homebrew fonts.

brew tap caskroom/fonts

fonts=(
  font-inconsolata
  font-source-code-pro
  font-ubuntu
)

echo "installing fonts..."
brew cask install ${fonts[@]}


### Set up system defaults.

echo "setting up system defaults"

# Disable sound on boot
sudo nvram SystemAudioVolume=" "

# Disable transparency in the menu bar and elsewhere in Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool true
# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true
# # Automatically quit printer app once the print jobs complete
# defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock in
# the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes and smart dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable the sudden motion sensor, as it's not useful for SSDs
sudo pmset -a sms 0

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# Enable keyboard access for all controls (e.g. enable tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true
# Set Downloads as the default location for new Finder windows
# (For Desktop, use `PfDe` and `file://${HOME}/Desktop/`)
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# # Enable spring loading for directories
# defaults write NSGlobalDomain com.apple.springing.enabled -bool true
# # Remove the spring loading delay for directories
# defaults write NSGlobalDomain com.apple.springing.delay -float 0
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# Use list view in all Finder windows by default
# Codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# # Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# # Disable disk image verification
# defaults write com.apple.frameworks.diskimages skip-verify -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# # Disable the warning before emptying the Trash
# defaults write com.apple.finder WarnOnEmptyTrash -bool false
# # Empty Trash securely by default
# defaults write com.apple.finder EmptyTrashSecurely -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array
# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false
# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# # Hot corners
# # Properties are named wvous-XX-corner where possible values for XX are:
# #     tr, tl, br, bl
# # Possible property values:
# #  0: no-op
# #  2: Mission Control
# #  3: Show application windows
# #  4: Desktop
# #  5: Start screen saver
# #  6: Disable screen saver
# #  7: Dashboard
# # 10: Put display to sleep
# # 11: Launchpad
# # 12: Notification Center
# #
# # Bottom left screen corner -> blank screen
# defaults write com.apple.dock wvous-bl-corner -int 10
# defaults write com.apple.dock wvous-bl-modifier -int 0

# Safari: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# Safari: press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Spotlight: Disable indexing for any volume that gets mounted and has not yet
# been indexed before. Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing
# any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null


killall Dock Finder


### Notify user to manually install other software.

echo You may want to manually install:
echo   - Microsoft Office
echo   - ScanSnap
echo   - Yesware
echo
echo Optionally, run install-dev.sh to set up a dev environment.
