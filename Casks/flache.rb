cask "flache" do
  version "1.4.0"
  sha256 "fa31067f1af3e6284d2447f8695d72f9dc9d0fc2ff59468c3f4648d335aaf2e3"

  url "https://github.com/spurious-cox/flache/releases/download/v#{version}/Flache-#{version}.dmg"
  name "Flache"
  desc "Floating dock for chosen applications, shown and hidden by a hotkey"
  homepage "https://github.com/spurious-cox/flache"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Flache.app"

  # The uninstall stanza below deletes the login agent's plist, so "Open
  # Flache at login" would turn itself off on every upgrade. The plist is put aside
  # before the old copy is uninstalled and restored afterwards.
  postflight_steps do
    if_path_exists "Library/Caches/Homebrew/flache-login-agent.plist", base: :home do
      copy "Library/Caches/Homebrew/flache-login-agent.plist",
           "Library/LaunchAgents/com.timmccoy.flache.plist",
           source_base: :home, target_base: :home
      # Nothing here restarts the agent: Homebrew runs these steps in a
      # sandbox that cannot reach launchd or Launch Services, so launchctl
      # bootstrap and open both fail. The restored plist is loaded at the
      # next login, or the app is opened by hand before then.
      remove "Library/Caches/Homebrew/flache-login-agent.plist", base: :home
    end
  end

  # UNINSTALL preflight, not install preflight: an upgrade uninstalls the old
  # cask first, so by the time the install side runs the plist is gone.
  uninstall_preflight_steps do
    if_path_exists "Library/LaunchAgents/com.timmccoy.flache.plist", base: :home do
      copy "Library/LaunchAgents/com.timmccoy.flache.plist",
           "Library/Caches/Homebrew/flache-login-agent.plist",
           source_base: :home, target_base: :home
    end
  end

  # The login agent has KeepAlive. A running copy must be stopped before the
  # bundle is replaced, or launchd restarts the OLD one mid-upgrade.
  uninstall launchctl: "com.timmccoy.flache",
            quit:      "com.timmccoy.flache"

  zap trash: [
    "~/Library/LaunchAgents/com.timmccoy.flache.plist",
    "~/Library/Preferences/com.timmccoy.flache.plist",
    "~/Library/Saved Application State/com.timmccoy.flache.savedState",
  ]

  caveats <<~EOS
    An upgrade stops Flache. Open it again afterwards; if "Open Flache at login"
    is on, it also starts at your next login.
  EOS
end
