cask "pixprosortlayers" do
  version "2.1.3"
  sha256 "1662128d93645ebbbdf6fa1bf8e5308678561ae4a72822d8c3748379ff6f658a"

  url "https://github.com/spurious-cox/pixprosortlayers/releases/download/v#{version}/PixProSortLayers-#{version}.dmg"
  name "PixProSortLayers"
  desc "Sort selected Pixelmator Pro layers by their position on the canvas"
  homepage "https://github.com/spurious-cox/pixprosortlayers"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The applet stub carries the minimum macOS of the machine that built it,
  # stamped back to 26 at build time.
  depends_on macos: :tahoe

  app "PixProSortLayers.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixprosortlayers.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprosortlayers.savedState",
  ]

  caveats <<~EOS
    PixProSortLayers drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed. Both Pixelmator Pro 3.x
    and the Creator Studio build are supported.
  EOS
end
