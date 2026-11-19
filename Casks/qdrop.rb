cask "qdrop" do
  version "1.4.1"
  sha256 "b69e16431b3cd7bf53c07fc66b88abf7922e8e5ead8d82f7192c255e3cd87c0e"

  url "https://github.com/spurious-cox/qdrop/releases/download/v#{version}/QDrop-#{version}.dmg"
  name "QDrop"
  desc "Menu bar app for sending files, links, text and screenshots with AirDrop"
  homepage "https://github.com/spurious-cox/qdrop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "QDrop.app"

  uninstall quit: "com.timmccoy.qdrop"

  zap trash: [
    "~/Library/Application Support/QDrop",
    "~/Library/Preferences/com.timmccoy.qdrop.plist",
  ]
end
