cask "pixproshaper" do
  version "2.6.1"
  sha256 "3d9eb22b42d4984b6f2d027edc6c3d7219f29651d57beaa1fcdc722b7b1d4286"

  url "https://github.com/spurious-cox/pixproshaper/releases/download/v#{version}/PixProShaper-#{version}.dmg"
  name "PixProShaper"
  desc "Turn selected Pixelmator Pro layers into shapes"
  homepage "https://github.com/spurious-cox/pixproshaper"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProShaper.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixproshaper.plist",
    "~/Library/Saved Application State/com.timmccoy.pixproshaper.savedState",
  ]

  caveats <<~EOS
    PixProShaper drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
