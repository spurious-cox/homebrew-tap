cask "pixprosimplify" do
  version "2.5.4"
  sha256 "688a7a6e7a1f75279537c88d059fd5b10b8c77358c54cd635611e908d7c847e1"

  url "https://github.com/spurious-cox/pixprosimplify/releases/download/v#{version}/PixProSimplify-#{version}.dmg"
  name "PixProSimplify"
  desc "Reduce the anchor points of a Pixelmator Pro shape"
  homepage "https://github.com/spurious-cox/pixprosimplify"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "PixProSimplify.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixprosimplify.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprosimplify.savedState",
  ]

  caveats <<~EOS
    PixProSimplify drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
