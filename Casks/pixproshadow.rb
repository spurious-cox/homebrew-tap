cask "pixproshadow" do
  version "7.6.1"
  sha256 "eb4001ba428b06032d6106f7cfc47c244566bbe3d9c80face2aea55391505e27"

  url "https://github.com/spurious-cox/pixproshadow/releases/download/v#{version}/PixProShadow-#{version}.dmg"
  name "PixProShadow"
  desc "Extruded long-shadow behind a Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixproshadow"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProShadow.app"

  zap trash: [
    "~/.shadowtext_defaults.plist",
    "~/Library/Preferences/com.timmccoy.pixproshadow.plist",
    "~/Library/Saved Application State/com.timmccoy.pixproshadow.savedState",
  ]

  caveats <<~EOS
    PixProShadow drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
