cask "pixproshaper" do
  version "2.6.0"
  sha256 "c149a77217d54f0900b888cd7958b179482510bbc8e713f89eae15871617938f"

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
