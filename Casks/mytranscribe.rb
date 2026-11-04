cask "mytranscribe" do
  version "2.8.1"
  sha256 "4867b4413c7b11c052bb7e38db255ab3596fe8d80b6dc4326dfa7a08bc7e2d95"

  url "https://github.com/spurious-cox/MyTranscribe/releases/download/v#{version}/MyTranscribe-#{version}.dmg"
  name "MyTranscribe"
  desc "Transcribes system audio or your microphone on-device with Whisper"
  homepage "https://github.com/spurious-cox/MyTranscribe"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "MyTranscribe.app"

  zap trash: [
    "~/Library/Logs/MyTranscribe.err",
    "~/Library/Logs/MyTranscribe.log",
    "~/Library/Preferences/com.timmccoy.mytranscribe.plist",
  ]

  caveats <<~EOS
    MyTranscribe asks for Screen & System Audio Recording (Mac audio) and
    Microphone the first time each is used. Type at cursor needs it turned on
    in System Settings > Privacy & Security > Device Control and Data Access
    (Accessibility before macOS 27).
  EOS
end
