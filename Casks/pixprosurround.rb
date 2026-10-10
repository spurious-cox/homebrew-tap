cask "pixprosurround" do
  version "1.7.6"
  sha256 "3bbba8c65d118b55e7f03d616b48d8b1c6b35c0a8812957649432db8b2b36eb4"

  url "https://github.com/spurious-cox/pixprosurround/releases/download/v#{version}/PixProSurround-#{version}.dmg"
  name "PixProSurround"
  desc "Full-circle glow around a Pixelmator Pro layer"
  homepage "https://github.com/spurious-cox/pixprosurround"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "PixProSurround.app"

  zap trash: [
    "~/.textsurround_defaults.plist",
    "~/Library/Preferences/com.timmccoy.pixprosurround.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprosurround.savedState",
  ]

  caveats <<~EOS
    PixProSurround drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
