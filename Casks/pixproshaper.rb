cask "pixproshaper" do
  version "2.5.0"
  sha256 "0fd9b680723792a6b8332d8b8f9920492d7f82b1d0d2caf5ac5a6576f06ba050"

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
