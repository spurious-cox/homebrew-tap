cask "tinyvoca" do
  version "1.1.0"
  sha256 "6c354bb4f06b2b083fa15a79dc7d43c96c7a3df7a461f95bb1b13ac9835f43cc"

  url "https://github.com/spurious-cox/tinyvoca/releases/download/v#{version}/TinyVoca-#{version}.dmg"
  name "TinyVoca"
  desc "Tester for the tiny-voca text-to-speech model and the macOS system voices"
  homepage "https://github.com/spurious-cox/tinyvoca"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "TinyVoca.app"

  zap trash: [
    "~/Library/Application Support/TinyVoca",
    "~/Library/Saved Application State/com.timmccoy.tinyvoca.savedState",
  ]

  caveats <<~EOS
    On first launch TinyVoca sets itself up: it needs Python 3.10 or newer
    (brew install python) and an internet connection to download PyTorch,
    tiny-voca and the model weights, about 300 MB, one time.
  EOS
end
