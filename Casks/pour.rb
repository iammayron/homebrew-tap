cask "pour" do
  version "0.1.4"
  sha256 "ddab3496cc2b4ba308d23d4f167816c2ceaca0437417d7df8939378fe4766ffc"

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
