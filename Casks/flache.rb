cask "flache" do
  version "1.2.2"
  sha256 "28ee2dea2b87eee4c5f24e65075297657c3597e9637518d27ddcf866027d1c72"

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

  # Replacing the bundle deletes the login agent's plist, so "Open Flache at
  # login" would turn itself off on every upgrade. The plist is put aside
  # before the old copy is uninstalled and restored afterwards.
  postflight_steps do
    if_path_exists "Library/Caches/Homebrew/flache-login-agent.plist", base: :home do
      copy "Library/Caches/Homebrew/flache-login-agent.plist",
           "Library/LaunchAgents/com.timmccoy.flache.plist",
           source_base: :home, target_base: :home
      remove "Library/Caches/Homebrew/flache-login-agent.plist", base: :home
      # Through a shell so the uid and home directory are expanded there:
      # a steps block takes no Ruby interpolation, and launchctl expands
      # neither ~ nor $HOME itself.
      run "/bin/sh",
          args:         ["-c",
                         "/bin/launchctl bootstrap gui/$(id -u) " \
                         "\"$HOME/Library/LaunchAgents/com.timmccoy.flache.plist\""],
          must_succeed: false
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

  zap trash: [
    "~/Library/LaunchAgents/com.timmccoy.flache.plist",
    "~/Library/Preferences/com.timmccoy.flache.plist",
    "~/Library/Saved Application State/com.timmccoy.flache.savedState",
  ]
end
