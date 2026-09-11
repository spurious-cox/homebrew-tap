cask "stache" do
  version "2.5.0"
  sha256 "fd9dcc36062afede23133d5c2dca428b2a5e658a6d15f51e0ca7704353d4b6e4"

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
      remove "Library/Caches/Homebrew/stache-login-agent.plist", base: :home
      # Through a shell so the uid and the home directory are expanded there:
      # a steps block takes no Ruby interpolation, and launchctl expands
      # neither ~ nor $HOME itself.
      run "/bin/sh",
          args:         ["-c",
                         "/bin/launchctl bootstrap gui/$(id -u) " \
                         "\"$HOME/Library/LaunchAgents/com.timmccoy.stache.plist\""],
          must_succeed: false
    end
  end

  # ...but that also DELETES the agent's plist, so "Open Stache at login"
  # silently turned itself off on every upgrade. The file is put aside before
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

  zap trash: [
    "~/Library/Application Support/Stache",
    "~/Library/Caches/Stache",
    "~/Library/LaunchAgents/com.timmccoy.stache.plist",
    "~/Library/Preferences/com.timmccoy.stache.plist",
    "~/Library/Saved Application State/com.timmccoy.stache.savedState",
  ]
end
