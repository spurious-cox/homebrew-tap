cask "pixproshadow" do
  version "7.5.2"
  sha256 "2c2e6c1af00c9483acfb8ffbc5d583ed6f0550455e037676aefed60c8f6e843e"

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
