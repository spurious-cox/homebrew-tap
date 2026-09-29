cask "pixprospeed" do
  version "2.6.4"
  sha256 "15b30c1eb9343bd2d1b90e5020eee9656a70f2adbf32fe25537058113289202b"

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
