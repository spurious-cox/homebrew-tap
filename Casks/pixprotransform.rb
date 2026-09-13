cask "pixprotransform" do
  version "1.3.0"
  sha256 "01e78c3867b3172c6b2abdce41bd4454db6a16196bd41c895bf3a393acfae503"

  url "https://github.com/spurious-cox/pixprotransform/releases/download/v#{version}/PixProTransform-#{version}.dmg"
  name "PixProTransform"
  desc "Open Pixelmator Pro's Perspective Transform in one step"
  homepage "https://github.com/spurious-cox/pixprotransform"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProTransform.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixprotransform.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprotransform.savedState",
  ]

  caveats <<~EOS
    PixProTransform drives Pixelmator Pro, which must be installed, and it works by
    driving Pixelmator's own interface — so it needs Accessibility access
    under System Settings, Privacy & Security, Accessibility. It also asks
    for permission to control Pixelmator Pro the first time it runs. Without
    both it can do nothing at all.
  EOS
end
