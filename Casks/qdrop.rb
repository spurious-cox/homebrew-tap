cask "qdrop" do
  version "1.4.3"
  sha256 "d2d74091ff84e17f3f6299bb0c36d015d8e1649c39b1d89e87a0bbc40979f979"

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
