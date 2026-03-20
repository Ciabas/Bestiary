# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://github.com/paulmillr/dotfiles/blob/master/etc/macos-settings.sh


# Security
# ========

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Evict FileVault keys from memory when going to sleep, instead of storing them in memory.
sudo pmset -a destroyfvkeyonstandby 1


# Energy saving
# =============

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically on power loss
sudo pmset -a autorestart 1

# Sleep the display after 10 minutes
sudo pmset -a displaysleep 10

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 12 minutes on battery
sudo pmset -b sleep 12

# Set standby delay to 24 hour
sudo pmset -a standbydelay 86400

# Enforce system hibernation instead of traditional sleep to memory.
# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
# 25: Force copying RAM to disk always
sudo pmset -a destroyfvkeyonstandby 1
sudo pmset -a hibernatemode 25

# Also modify your standby and power nap settings.
# Otherwise, your machine may wake while in standby mode and then
# power off due to the absence of the FileVault key
sudo pmset -a powernap 0
sudo pmset -a standby 0


# Screen
# ======

# Don't show floating thumbnail after taking screenshot
defaults write com.apple.screencapture show-thumbnail -bool false

# Save screenshots to Pictures folder (default)
defaults write com.apple.screencapture location -string "~/Pictures"

# Show click sounds in screenshots
defaults write com.apple.screencapture showsClicks -bool true

# Save screenshots as files (not clipboard)
defaults write com.apple.screencapture target -string "file"

# Enable video recording in screenshot tool
defaults write com.apple.screencapture video -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1


# Finder
# ======

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"


# Others
# ======

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Hot Corners
# Bottom-right corner.
#  5: Start screen saver
# 13: Lock Screen
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en-PL" "pl-PL"
defaults write NSGlobalDomain AppleLocale -string "en_PL@currency=PLN"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Stop iTunes from responding to the keyboard media keys
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null


# Dock
# ====

# Set the icon size of Dock items to 56 pixels
defaults write com.apple.dock tilesize -int 56

# Don't show recent apps in dock
defaults write com.apple.dock show-recents -bool false

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false


for app in "Dock" "Finder" "SystemUIServer" "Terminal"; do
    killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
