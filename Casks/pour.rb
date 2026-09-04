cask "pour" do
  version "0.1.2"
  sha256 "6d4e74e369d14c85fa0cb7f8fb4ba584eb08d6438053ca47cf52eddf2edb9bd4"

  url "https://github.com/iammayron/pour/releases/download/v#{version}/Pour-#{version}.zip"
  name "Pour"
  desc "Menu bar Pomodoro for Todoist with a floating liquid-glass card"
  homepage "https://github.com/iammayron/pour"

  # Unsigned (no Apple Developer ID). Homebrew 6 dropped --no-quarantine,
  # so the quarantine flag is stripped after install.
  auto_updates false
  depends_on macos: :sonoma

  app "Pour.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Pour.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.mayron.pour.plist",
    "~/Library/Saved Application State/com.mayron.pour.savedState",
  ]

  caveats <<~EOS
    Pour is not signed with an Apple Developer ID. The quarantine flag is
    removed on install. If macOS still blocks launch, run:
      xattr -dr com.apple.quarantine "#{appdir}/Pour.app"
  EOS
end
