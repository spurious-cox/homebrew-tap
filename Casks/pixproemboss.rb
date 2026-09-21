cask "pixproemboss" do
  version "2.7.3"
  sha256 "bba54f71e718d9071f6d3b206a120d8992753e8c96ea772fdae80cf0909c7b62"

  url "https://github.com/spurious-cox/pixproemboss/releases/download/v#{version}/PixProEmboss-#{version}.dmg"
  name "PixProEmboss"
  desc "Emboss a selected Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixproemboss"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "PixProEmboss.app"

  zap trash: [
    "~/.pixproemboss_defaults.plist",
    "~/Library/Preferences/com.timmccoy.pixproemboss.plist",
    "~/Library/Saved Application State/com.timmccoy.pixproemboss.savedState",
  ]

  caveats <<~EOS
    PixProEmboss drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
