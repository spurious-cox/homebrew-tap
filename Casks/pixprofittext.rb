cask "pixprofittext" do
  version "3.5.2"
  sha256 "79c4c6ceec88e5316a2924359a9a31586e89567c296a108bad321773edec8e0c"

  url "https://github.com/spurious-cox/pixprofittext/releases/download/v#{version}/PixProFitText-#{version}.dmg"
  name "PixProFitText"
  desc "Fits text inside an irregular Pixelmator Pro shape"
  homepage "https://github.com/spurious-cox/pixprofittext"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "PixProFitText.app"

  zap trash: [
    "~/Library/Caches/PixProFitText",
    "~/Library/Logs/PixProFitText.log",
    "~/Library/Preferences/com.timmccoy.pixprofittext.plist",
    "~/Library/Saved Application State/com.timmccoy.pixprofittext.savedState",
  ]

  caveats <<~EOS
    PixProFitText drives Pixelmator Pro, which must be installed. The first
    time it runs, macOS asks whether to allow it to control Pixelmator Pro;
    it can do nothing at all until that is allowed.
  EOS
end
