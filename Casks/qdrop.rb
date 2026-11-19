cask "qdrop" do
  version "1.4.2"
  sha256 "39c6d3ab0dfcf219ab9f302d4ceca7448545b0cc5c49797150639f8941fe177f"

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
