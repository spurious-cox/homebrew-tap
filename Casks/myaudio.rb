cask "myaudio" do
  version "1.4.4"
  sha256 "fb3d076516399dbed272b44532f4391d8f4aaa42b03f7940075298eac160130b"

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

  # The AirPlay agent runs under launchd, outside the app, because that is the
  # only way it can hold Local Network permission. Stopping it here keeps
  # launchd from restarting the old copy in the middle of an upgrade.
  #
  # This stanza also deletes the agent's plist, which for most apps would turn
  # a login item off on every upgrade. Not here: MyAudio writes the plist
  # itself at launch, naming its own bundle, so the next start puts it back.
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
