cask "tmsearch" do
  version "1.7.1"
  sha256 "2928a2206660c6f87a81ab816ec6722a13b4f50e942b3c3256965408c6c29a8b"

  url "https://github.com/spurious-cox/tmsearch/releases/download/v#{version}/TMsearch-#{version}.dmg"
  name "TMsearch"
  desc "Find and restore past versions of a file from Time Machine backups"
  homepage "https://github.com/spurious-cox/tmsearch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "TMsearch.app"
  # A wrapper script that runs the app's own executable. A link straight to
  # Contents/MacOS/TMsearch does not work: the app cannot find itself through it.
  binary "#{appdir}/TMsearch.app/Contents/Resources/tmsearch"

  zap trash: "~/Library/Preferences/com.timmccoy.tmsearch.plist"

  caveats <<~EOS
    TMsearch reads Time Machine backups, which macOS allows only with Full Disk
    Access. Turn it on in System Settings > Privacy & Security > Full Disk
    Access for TMsearch (to use it from Finder) and for your terminal app (to
    use the tmsearch command).

    In zsh, quote a name that has * or ?, or add this to ~/.zshrc:
      alias tmsearch='noglob tmsearch'
  EOS
end
