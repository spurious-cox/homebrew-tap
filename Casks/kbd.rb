cask "kbd" do
  version "1.6.0"
  sha256 "dd97e1cd2e9429541cc6399d0f968064c29aa7050beaa48927abe013bf6a5767"

  url "https://github.com/spurious-cox/kbd/releases/download/v#{version}/KBD-#{version}.dmg"
  name "KBD"
  desc "Floating numeric keypad that types into any application's text field"
  homepage "https://github.com/spurious-cox/kbd"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "KBD.app"

  caveats <<~EOS
    KBD needs Accessibility permission before its keys can type into other
    applications:

      System Settings -> Privacy & Security -> Accessibility -> enable KBD

    It asks for this the first time you open it. Uninstalling KBD does not
    remove it from that list -- macOS does not let an installer change those
    entries, so remove it there by hand if you want it gone.
  EOS

  zap trash: [
    "~/Library/Preferences/com.timmccoy.kbd.plist",
    "~/Library/Saved Application State/com.timmccoy.kbd.savedState",
  ]
end
