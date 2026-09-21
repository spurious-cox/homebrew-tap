cask "pixproemboss" do
  version "2.7.2"
  sha256 "017868081f17e7171a76571a8dad867199d5830b6e7e2ee58da336c0815c27bc"

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
