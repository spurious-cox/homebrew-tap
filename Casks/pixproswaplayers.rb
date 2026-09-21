cask "pixproswaplayers" do
  version "3.1.0"
  sha256 "1af773e1d748af85a2d9fd24699f0f17f7bbda7c31d1c5c323655a13027b5e48"

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
