cask "pixproshaper" do
  version "2.6.2"
  sha256 "7cbb4ffa5f8ccf613c0f210591715b15c80db320735088a9642bfe0337c0ab56"

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
