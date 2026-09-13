cask "pixproshadow" do
  version "7.6.0"
  sha256 "286b56284c7abdae60f4a19c3b74f31d2ccd1ac4e1a01eec566305bff20495c8"

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
