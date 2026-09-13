cask "pixprosimplify" do
  version "2.5.0"
  sha256 "a61d17968561089ca2473ce9a87dce10ba1057c1783c632e87e2afcbb7688ff5"

  url "https://github.com/spurious-cox/pixprosimplify/releases/download/v#{version}/PixProSimplify-#{version}.dmg"
  name "PixProSimplify"
  desc "Reduce the anchor points of a Pixelmator Pro shape"
  homepage "https://github.com/spurious-cox/pixprosimplify"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

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
