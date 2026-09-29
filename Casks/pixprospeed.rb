cask "pixprospeed" do
  version "2.6.5"
  sha256 "43b87db9030b8751ae2d79e4d19fa8e53e19a726cc84cc13c7d37bc7f2d43b3b"

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
