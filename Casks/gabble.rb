cask "gabble" do
  version "1.2.0"
  sha256 "ac6d05870825c782b3bfd566fc4a446935cbc48322432b8e7a649aedc957165e"

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
