cask "stache" do
  version "1.17.1"
  sha256 "518ae1ad874aa0efd0a4bed7de16013df91b3e7ce2bc17875fec5e1c5d78d153"

  url "https://github.com/spurious-cox/stache/releases/download/v#{version}/Stache-#{version}.dmg"
  name "Stache"
  desc "Clipboard history for text and images, recalled by a hotkey"
  homepage "https://github.com/spurious-cox/stache"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Stache.app"

  # Stache installs a LaunchAgent when "Open Stache at login" is switched on,
  # and that agent has KeepAlive. A running copy must be stopped before the
  # bundle is replaced, or launchd restarts the OLD one mid-upgrade and the
  # new version appears not to install at all.
  uninstall launchctl: "com.timmccoy.stache",
            quit:      "com.timmccoy.stache"

  zap trash: [
    "~/Library/Application Support/Stache",
    "~/Library/Caches/Stache",
    "~/Library/LaunchAgents/com.timmccoy.stache.plist",
    "~/Library/Preferences/com.timmccoy.stache.plist",
    "~/Library/Saved Application State/com.timmccoy.stache.savedState",
  ]
end
