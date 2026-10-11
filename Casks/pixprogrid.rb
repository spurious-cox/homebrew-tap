cask "pixprogrid" do
  version "1.6.0"
  sha256 "e8ba52133cc0fd59939031d977b588b4e03090ff159cf14f122c061cfe5b120a"

  url "https://github.com/spurious-cox/pixprogrid/releases/download/v#{version}/PixProGrid-#{version}.dmg"
  name "PixProGrid"
  desc "Hide Pixelmator Pro's grid for clean screenshots"
  homepage "https://github.com/spurious-cox/pixprogrid"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProGrid.app"

  zap trash: [
    "~/Library/Application Support/PixProGrid",
    "~/Library/Preferences/com.timmccoy.pixprogrid.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprogrid.savedState",
  ]

  caveats <<~EOS
    PixProGrid drives Pixelmator Pro, which must be installed, and it works by
    driving Pixelmator's own interface — so it needs Accessibility access
    under System Settings, Privacy & Security, Accessibility. It also asks
    for permission to control Pixelmator Pro the first time it runs. Without
    both it can do nothing at all.
  EOS
end
