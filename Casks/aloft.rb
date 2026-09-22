cask "aloft" do
  version "1.0.2"
  sha256 "e4ce946e5de69d25f4a2e86441c76e35de14015c658282bfa634fe37602312d3"

  url "https://github.com/iammayron/aloft/releases/download/v#{version}/Aloft-#{version}.dmg"
  name "Aloft"
  desc "Menu bar app that keeps any window on top, picked from live previews"
  homepage "https://github.com/iammayron/aloft"

  # Unsigned (no Apple Developer ID). Homebrew 6 dropped --no-quarantine,
  # so the quarantine flag is stripped after install.
  auto_updates false
  depends_on macos: :tahoe

  app "Aloft.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Aloft.app"]
  end

  zap trash: [
    "~/Library/Caches/dev.mayron.aloft",
    "~/Library/HTTPStorages/dev.mayron.aloft",
    "~/Library/Preferences/dev.mayron.aloft.plist",
    "~/Library/Saved Application State/dev.mayron.aloft.savedState",
  ]

  caveats <<~EOS
    Aloft is not signed with an Apple Developer ID. The quarantine flag is
    removed on install. If macOS still blocks launch, run:
      xattr -dr com.apple.quarantine "#{appdir}/Aloft.app"

    Aloft needs Accessibility and Screen Recording. It asks for both on
    first run and explains what each one is for.
  EOS
end
