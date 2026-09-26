cask "stache" do
  version "2.12.0"
  sha256 "92d3c416a18dcf08f6753e892ca81283c703c9b936c950d40d360db4ab09f355"

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

  postflight_steps do
    if_path_exists "Library/Caches/Homebrew/stache-login-agent.plist", base: :home do
      copy "Library/Caches/Homebrew/stache-login-agent.plist",
           "Library/LaunchAgents/com.timmccoy.stache.plist",
           source_base: :home, target_base: :home
      # Nothing here restarts the agent: Homebrew runs these steps in a
      # sandbox that cannot reach launchd or Launch Services, so launchctl
      # bootstrap and open both fail. The restored plist is loaded at the
      # next login, or the app is opened by hand before then.
      remove "Library/Caches/Homebrew/stache-login-agent.plist", base: :home
    end
  end

  # The uninstall stanza below also DELETES the agent's plist, so "Open
  # Stache at login" silently turned itself off on every upgrade. The file is put aside before
  # the upgrade and restored after it, rather than written from scratch here:
  # the app owns its contents, and a copy of them in a cask would be one more
  # thing to keep in step.
  #
  # UNINSTALL preflight, not install preflight: an upgrade uninstalls the old
  # cask first, and that is what deletes the plist — by the time the install
  # side runs there is nothing left to put aside. Measured, by watching a
  # reinstall throw the agent away with the stanza sitting right there.
  uninstall_preflight_steps do
    if_path_exists "Library/LaunchAgents/com.timmccoy.stache.plist", base: :home do
      copy "Library/LaunchAgents/com.timmccoy.stache.plist",
           "Library/Caches/Homebrew/stache-login-agent.plist",
           source_base: :home, target_base: :home
    end
  end

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

  caveats <<~EOS
    An upgrade stops Stache. Open it again afterwards; if "Open Stache at login"
    is on, it also starts at your next login.
  EOS
end
