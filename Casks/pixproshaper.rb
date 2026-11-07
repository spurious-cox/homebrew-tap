cask "pixproshaper" do
  version "2.6.3"
  sha256 "b9e97c31a53a3227a5b6aa682df91081d03b71d7c41eba9ed4f399489b7ab618"

  url "https://github.com/spurious-cox/pixproshaper/releases/download/v#{version}/PixProShaper-#{version}.dmg"
  name "PixProShaper"
  desc "Turn selected Pixelmator Pro layers into shapes"
  homepage "https://github.com/spurious-cox/pixproshaper"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProShaper.app"

  zap trash: [
    "~/Library/Preferences/com.timmccoy.pixproshaper.plist",
    "~/Library/Saved Application State/com.timmccoy.pixproshaper.savedState",
  ]

  caveats <<~EOS
    PixProShaper drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
