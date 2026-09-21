cask "pixproshadow" do
  version "7.6.3"
  sha256 "17de607cf75cd10c9c06b1a1b30304b1874f78c8e63f90c7ba327e359a335c1a"

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
