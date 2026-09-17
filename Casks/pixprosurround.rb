cask "pixprosurround" do
  version "1.7.1"
  sha256 "fb4bc9c9b3381622983e0e9496f45d8ab93eefc9907efe669487aacbc694bd65"

  url "https://github.com/spurious-cox/pixprosurround/releases/download/v#{version}/PixProSurround-#{version}.dmg"
  name "PixProSurround"
  desc "Full-circle glow around a Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixprosurround"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

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
