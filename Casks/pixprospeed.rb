cask "pixprospeed" do
  version "2.6.1"
  sha256 "deeb840415af820b8dc355a3d15d90e759e1da2c831ec379dc720955aaa67eb0"

  url "https://github.com/spurious-cox/pixprospeed/releases/download/v#{version}/PixProSpeed-#{version}.dmg"
  name "PixProSpeed"
  desc "Motion and speed trails for a Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixprospeed"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProSpeed.app"

  zap trash: [
    "~/.pixprospeed_defaults.plist",
    "~/Library/Logs/PixProSpeed.log",
    "~/Library/Preferences/com.timmccoy.pixprospeed.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprospeed.savedState",
  ]

  caveats <<~EOS
    PixProSpeed drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
