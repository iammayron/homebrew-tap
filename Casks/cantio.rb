cask "cantio" do
  version "1.0.6"
  sha256 "6c46b8f80be800f9d2cff1d1d8a1c7ea35a4887ee925a16b73f4a1f34ddeee7e"

  url "https://github.com/iammayron/cantio/releases/download/v#{version}/Cantio-#{version}.dmg"
  name "Cantio"
  desc "Floating Spotify lyrics for the menu bar"
  homepage "https://github.com/iammayron/cantio"

  # Unsigned (no Apple Developer ID). Install with --no-quarantine so
  # Gatekeeper doesn't block first launch.
  auto_updates false
  depends_on macos: :sonoma

  app "Cantio.app"

  zap trash: [
    "~/Library/Application Support/com.mayronalves.cantio",
    "~/Library/Caches/com.mayronalves.cantio",
    "~/Library/Preferences/com.mayronalves.cantio.plist",
  ]

  caveats <<~EOS
    Cantio is not signed with an Apple Developer ID. Install with:
      brew install --cask --no-quarantine cantio
    If you already installed it and macOS blocks launch, run:
      xattr -dr com.apple.quarantine "#{appdir}/Cantio.app"
  EOS
end
