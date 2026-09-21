cask "pixprosurround" do
  version "1.7.2"
  sha256 "914af88834df287adc2ce51d7f3401ce9fe1b43459f1c783a0101f46b193b2f1"

  url "https://github.com/spurious-cox/pixprosurround/releases/download/v#{version}/PixProSurround-#{version}.dmg"
  name "PixProSurround"
  desc "Full-circle glow around a Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixprosurround"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "PixProSurround.app"

  zap trash: [
    "~/.textsurround_defaults.plist",
    "~/Library/Preferences/com.timmccoy.pixprosurround.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprosurround.savedState",
  ]

  caveats <<~EOS
    PixProSurround drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
