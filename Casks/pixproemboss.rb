cask "pixproemboss" do
  version "2.7.1"
  sha256 "4df800d4a3552053dd0670681525476429f23759b552ab9ae6c8025449097d69"

  url "https://github.com/spurious-cox/pixproemboss/releases/download/v#{version}/PixProEmboss-#{version}.dmg"
  name "PixProEmboss"
  desc "Emboss a selected Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixproemboss"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

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
