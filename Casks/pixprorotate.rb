cask "pixprorotate" do
  version "2.2.0"
  sha256 "35bb6227786f9e03d3cf40851f9c043de8a9a8989508abca07e162d3f31c2564"

  url "https://github.com/spurious-cox/pixprorotate/releases/download/v#{version}/PixProRotate-#{version}.dmg"
  name "PixProRotate"
  desc "Rotate selected Pixelmator Pro layers either way, compass-style"
  homepage "https://github.com/spurious-cox/pixprorotate"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "PixProRotate.app"

  zap trash: [
    "~/Library/Logs/PixProRotate.log",
    "~/Library/Preferences/com.timmccoy.pixprorotate.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprorotate.savedState",
  ]

  caveats <<~EOS
    PixProRotate drives Pixelmator Pro, which must be installed. The first time
    it runs, macOS asks whether to allow it to control Pixelmator Pro; it can do
    nothing until that is allowed. Both Pixelmator Pro 3.x and the Creator Studio
    build are supported.

    For the arrow keys and number keys to work while Pixelmator Pro is the
    active app, also allow PixProRotate in System Settings > Privacy & Security
    > Accessibility.
  EOS
end
