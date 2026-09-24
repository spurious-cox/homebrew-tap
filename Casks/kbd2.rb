cask "kbd2" do
  version "1.5.1"
  sha256 "6aaaf60845838ce7cf6ceb6a6599ca60ed67ada6b7c6472bfa3e5978ec812f48"

  url "https://github.com/spurious-cox/kbd2/releases/download/v#{version}/KBD2-#{version}.dmg"
  name "KBD2"
  desc "Floating alphanumeric keyboard that types into any application's text field"
  homepage "https://github.com/spurious-cox/kbd2"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "KBD2.app"

  caveats <<~EOS
    KBD2 needs Accessibility permission before its keys can type into other
    applications:

      System Settings -> Privacy & Security -> Accessibility -> enable KBD2

    It asks for this the first time you open it. Uninstalling KBD2 does not
    remove it from that list -- macOS does not let an installer change those
    entries, so remove it there by hand if you want it gone.
  EOS

  zap trash: [
    "~/Library/Preferences/com.timmccoy.kbd2.plist",
    "~/Library/Saved Application State/com.timmccoy.kbd2.savedState",
  ]
end
