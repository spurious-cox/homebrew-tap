cask "myaudio" do
  version "1.6.0"
  sha256 "e1f8d2cd9604196360876daa3e5d702eb01a1ff291e3201e9b836d9c4b7a75b5"

  url "https://github.com/spurious-cox/myaudio/releases/download/v#{version}/MyAudio-#{version}.dmg"
  name "MyAudio"
  desc "Audio output panel for Bluetooth, AirPlay and built-in devices"
  homepage "https://github.com/spurious-cox/myaudio"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app ships a single arm64 binary, so brew must refuse an Intel Mac
  # rather than install something that cannot launch.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "MyAudio.app"

  postflight_steps do
    if_path_exists "Library/Caches/Homebrew/myaudio-agent.plist", base: :home do
      copy "Library/Caches/Homebrew/myaudio-agent.plist",
           "Library/LaunchAgents/com.timmccoy.myaudioagent.plist",
           source_base: :home, target_base: :home
      remove "Library/Caches/Homebrew/myaudio-agent.plist", base: :home
      # Through a shell so the uid and the home directory are expanded there:
      # a steps block takes no Ruby interpolation, and launchctl expands
      # neither ~ nor $HOME itself.
      run "/bin/sh",
          args:         ["-c",
                         "/bin/launchctl bootstrap gui/$(id -u) " \
                         "\"$HOME/Library/LaunchAgents/com.timmccoy.myaudioagent.plist\""],
          must_succeed: false
    end
  end

  # The uninstall stanza below deletes the agent's plist, so the AirPlay agent
  # stayed down after every upgrade until MyAudio was next opened. The file is
  # put aside before the old copy is removed and restored after the new one is
  # in place. The plist names /Applications/MyAudio.app, which is where the
  # new copy lands, and MyAudio still rewrites it at launch if it differs.
  #
  # UNINSTALL preflight, not install preflight: an upgrade uninstalls the old
  # cask first, and that is what deletes the plist.
  uninstall_preflight_steps do
    if_path_exists "Library/LaunchAgents/com.timmccoy.myaudioagent.plist", base: :home do
      copy "Library/LaunchAgents/com.timmccoy.myaudioagent.plist",
           "Library/Caches/Homebrew/myaudio-agent.plist",
           source_base: :home, target_base: :home
    end
  end

  # The AirPlay agent runs under launchd, outside the app, because that is the
  # only way it can hold Local Network permission. Stopping it here keeps
  # launchd from restarting the old copy in the middle of an upgrade.
  uninstall launchctl: "com.timmccoy.myaudioagent",
            quit:      "com.timmccoy.myaudioctl"

  zap trash: [
    "~/Library/Application Support/MyAudio",
    "~/Library/LaunchAgents/com.timmccoy.myaudioagent.plist",
    "~/Library/Logs/MyAudio.log",
    "~/Library/Logs/MyAudioAgent.err.log",
    "~/Library/Logs/MyAudioAgent.log",
    "~/Library/Preferences/com.timmccoy.myaudioctl.plist",
    "~/Library/Saved Application State/com.timmccoy.myaudioctl.savedState",
  ]

  caveats <<~EOS
    MyAudio finds AirPlay speakers with a background agent that macOS asks
    about the first time it runs: allow it to find devices on the local
    network, or the AirPlay rows stay empty. Bluetooth connect and disconnect
    needs its own permission, and without it the device list is read-only.

    Playing the Mac through an Apple TV needs Accessibility permission, since
    macOS offers that choice only in its own Sound settings, which MyAudio
    opens and closes for you.
  EOS
end
