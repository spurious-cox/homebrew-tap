cask "pixprorefsel" do
  version "1.4.1"
  sha256 "8b89aa057fb091867e7c88e464c4f9d349bbb4841af50a0edc6ae7c5c6ebb87f"

  url "https://github.com/spurious-cox/pixprorefsel/releases/download/v#{version}/PixProRefsel-#{version}.dmg"
  name "PixProRefsel"
  desc "Shrink or grow the active Pixelmator Pro selection with a slider"
  homepage "https://github.com/spurious-cox/pixprorefsel"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PixProRefsel.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixprorefsel.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprorefsel.savedState",
  ]

  caveats <<~EOS
    PixProRefsel drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
