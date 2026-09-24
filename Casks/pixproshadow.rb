cask "pixproshadow" do
  version "7.6.4"
  sha256 "3c6486fbcd151fc4082b0c115f408829382c89ffd1115baec94a6ff6949ad0d8"

  url "https://github.com/spurious-cox/pixproshadow/releases/download/v#{version}/PixProShadow-#{version}.dmg"
  name "PixProShadow"
  desc "Extruded long-shadow behind a Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixproshadow"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

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
