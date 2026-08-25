cask "gabble" do
  version "1.1.0"
  sha256 "4d1085b261cfbd0cd0d05513b3ba562c28da97b1641f3bcfaa1a33a046aa393e"

  url "https://github.com/iammayron/gabble/releases/download/v#{version}/Gabble-#{version}-arm64.dmg"
  name "Gabble"
  desc "Standalone desktop client for Google Chat"
  homepage "https://github.com/iammayron/gabble"

  # Unsigned (no Apple Developer ID). Install with --no-quarantine so
  # Gatekeeper doesn't block first launch.
  auto_updates false
  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Gabble.app"

  zap trash: [
    "~/Library/Application Support/Gabble",
    "~/Library/Preferences/com.mayron.gabble.plist",
    "~/Library/Saved Application State/com.mayron.gabble.savedState",
  ]

  caveats <<~EOS
    Gabble is not signed with an Apple Developer ID. Install with:
      brew install --cask --no-quarantine gabble
    If you already installed it and macOS blocks launch, run:
      xattr -dr com.apple.quarantine "#{appdir}/Gabble.app"
  EOS
end
