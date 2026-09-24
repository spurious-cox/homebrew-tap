cask "pixproswaplayers" do
  version "3.2.1"
  sha256 "5440b464fa535e2fd655cecb632d37743473d84cd913acea80234f36bae7d44a"

  url "https://github.com/spurious-cox/pixproswaplayers/releases/download/v#{version}/PixProSwapLayers-#{version}.dmg"
  name "PixProSwapLayers"
  desc "Swap the stacking order of selected Pixelmator Pro layers"
  homepage "https://github.com/spurious-cox/pixproswaplayers"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The applet stub carries the minimum macOS of the machine that built it,
  # stamped back to 26 at build time.
  depends_on macos: :tahoe

  app "PixProSwapLayers.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixproswaplayers.plist",
    "~/Library/Saved Application State/com.timmccoy.pixproswaplayers.savedState",
  ]

  caveats <<~EOS
    PixProSwapLayers drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed. Both Pixelmator Pro 3.x
    and the Creator Studio build are supported.
  EOS
end
