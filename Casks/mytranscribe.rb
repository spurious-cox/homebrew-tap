cask "mytranscribe" do
  version "2.9.0"
  sha256 "c079d684095dfb61125c215eb25f9eba649010e29ed477818dea785fe2038737"

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
