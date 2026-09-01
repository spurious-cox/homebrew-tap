cask "stache" do
  version "1.17.2"
  sha256 "4bc7165b6c746413ef54f6ae45f4c5906466e929003d1a730618039fdc44ec11"

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
