cask "pixprosplittext" do
  version "8.5.2"
  sha256 "954fa4b64fc102eb46014ec75efde3fd6e076b7634db63dde32694479ad4b4ef"

  url "https://github.com/spurious-cox/pixprosplittext/releases/download/v#{version}/PixProSplitText-#{version}.dmg"
  name "PixProSplitText"
  desc "Split a Pixelmator Pro text layer into even columns or rows"
  homepage "https://github.com/spurious-cox/pixprosplittext"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The applet stub comes from the system it was built on, and this one
  # reports a minimum of macOS 26. An older Mac would refuse to launch it.
  depends_on macos: :tahoe

  app "PixProSplitText.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixprosplittext.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprosplittext.savedState",
  ]

  caveats <<~EOS
    PixProSplitText drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed. Both Pixelmator Pro 3.x
    and the Creator Studio build are supported.
  EOS
end
