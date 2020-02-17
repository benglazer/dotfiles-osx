# install.sh

# First, execute these steps manually:
# 1. Complete the regular MacOS install process.
# 2. Open Preferences —> Time Machine -> Options. Check the boxes next to:
#        - Back up while on battery power and
#        - Exclude system files and applications
# 3. Complete an initial backup.
# 4. Open Terminal.app and run install script.


defaults read > defaults.orig.txt  # backup defaults


### Manual steps

# install 1password
# install Dropbox and Box
# log into App Store and install Magnet
# install the latest version of Alfred 3 from https://www.alfredapp.com/help/v3/
#   - most recently, this was: https://cachefly.alfredapp.com/Alfred_3.8.6_972.dmg
# dev tools other than (pyenv, pycharm)

# set Caps Lock to Control (doesn't change defaults)

# remove siri from Control Strip (deletes the following block:)
#     "com.apple.controlstrip" =     {
#         MiniCustomized =         (
#             "com.apple.system.brightness",
#             "com.apple.system.volume",
#             "com.apple.system.mute"
#         );
#     };



### Keyboard

# fast keyboard repeat rate
defaults write "Apple Global Domain" KeyRepeat 2
# low delay before repeat starts
defaults write "Apple Global Domain" InitialKeyRepeat 15
# tab to navigate between controls
defaults write "Apple Global Domain" AppleKeyboardUIMode 2
# disable spell check
defaults write "Apple Global Domain" NSAutomaticSpellingCorrectionEnabled 0
# disable auto-capitalization
defaults write "Apple Global Domain" NSAutomaticCapitalizationEnabled 0
# disable period on double-space
defaults write "Apple Global Domain" NSAutomaticPeriodSubstitutionEnabled 0
# disable "smart" quotes and dashes
defaults write "Apple Global Domain" NSAutomaticQuoteSubstitutionEnabled 0
defaults write "Apple Global Domain" NSAutomaticDashSubstitutionEnabled 0


### Trackpad

# fast trackpad
defaults write "Apple Global Domain" com.apple.trackpad.scaling 3
# tap-to-click
defaults write "com.apple.AppleMultitouchTrackpad" Clicking 1
# enable Exposé swipe down gesture 
defaults write "com.apple.dock" showAppExposeGestureEnabled 1
# swipe between full-screen spaces with four fingers
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadThreeFingerHorizSwipeGesture 0
# navigate back/forward between pages (three-finger swipe left/right)
defaults write "Apple Global Domain" AppleEnableSwipeNavigateWithScrolls 0
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadThreeFingerHorizSwipeGesture 1
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadThreeFingerHorizSwipeGesture 1
# disable Notification Center gesture (two-finger swipe left from right edge)
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadTwoFingerFromRightEdgeSwipeGesture 0
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadTwoFingerFromRightEdgeSwipeGesture 0


### Accessibility

# enable zoom using Control + two-finger swipe up/down
defaults write "com.apple.AppleMultitouchTrackpad" HIDScrollZoomModifierMask 262144
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" HIDScrollZoomModifierMask 262144
defaults write "com.apple.universalaccess" closeViewPanningMode 0
defaults write "com.apple.universalaccess" closeViewScrollWheelToggle 1
defaults write "com.apple.universalaccess" closeViewZoomFollowsFocus 1
defaults write "com.apple.universalaccess" closeViewSmoothImages 0
# enable dictation
defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMMessageTracesSinceLastReport 2
defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMUseOnlyOfflineDictation 1


### Dock

# remove app shortcuts from dock
defaults delete com.apple.dock persistent-apps
# don't show recents in dock
defaults write com.apple.dock show-recents 0
# auto-hide dock
defaults write com.apple.dock autohide 1


### Finder

# show all file extensions
defaults write "Apple Global Domain" AppleShowAllExtensions 1
# show warning before changing an extension
defaults write "com.apple.finder" FXEnableExtensionChangeWarning 0
# sort folders above files
defaults write "com.apple.finder" _FXSortFoldersFirst 1
# set default search scope to current directory
defaults write "com.apple.finder" FXDefaultSearchScope SCcf


### General

# restore open windows when re-opening an app
defaults write "Apple Global Domain" NSQuitAlwaysKeepsWindows 1
# show percent next to battery icon on toolbar
defaults write "com.apple.menuextra.battery" ShowPercent YES


### Restart affected services

killall Dock Finder



### Install and configure apps


### Homebrew

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# install gui apps
brew cask install firefox sublime-text iterm2
# install dev environment
brew cask install dash pycharm
brew install pyenv postgres

brew cask install calibre box-drive disk-inventory-x dropbox the-unarchiver tunnelblick vlc musicbrainz-picard nordvpn libreoffice


### Transmission

brew cask install transmission
# don't ask to follow the law
defaults write "org.m0k.transmission" WarningLegal 0
# autosize window to fit transfers
defaults write "org.m0k.transmission" AutoSize 1
# keep incomplete files in ~/Downloads
defaults write "org.m0k.transmission" UseIncompleteDownloadFolder 1
# delete original .torrent file when adding
defaults write "org.m0k.transmission" DeleteOriginalTorrent 1
# display options when manually adding a .torrent file
defaults write "org.m0k.transmission" DownloadAskManual 1
# don't allow uploads
defaults write "org.m0k.transmission" RatioCheck 1
defaults write "org.m0k.transmission" RatioLimit 0
defaults write "org.m0k.transmission" CheckUpload 1
defaults write "org.m0k.transmission" UploadLimit 0
defaults write "org.m0k.transmission" SpeedLimitUploadLimit 0

