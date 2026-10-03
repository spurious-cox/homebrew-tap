cask "pixprorefsel" do
  version "1.5.3"
  sha256 "f00ffdf54087b3a02acc1d15793a280f9ff68b749cda2ca6e21b8ee0d25a9ecc"

  url "https://github.com/spurious-cox/pixprorefsel/releases/download/v#{version}/PixProRefsel-#{version}.dmg"
  name "PixProRefsel"
  desc "Shrink or grow the active Pixelmator Pro selection with a slider"
  homepage "https://github.com/spurious-cox/pixprorefsel"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PixProRefsel.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixprorefsel.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprorefsel.savedState",
  ]

  caveats <<~EOS
    PixProRefsel drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
