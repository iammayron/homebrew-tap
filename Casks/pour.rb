cask "pour" do
  version "0.2.1"
  sha256 "06bf3d3ea10922ea4a11de150e751b641899c43018d5a8a5f93fe93f2939e7e1"

  url "https://github.com/iammayron/pour/releases/download/v#{version}/Pour-#{version}.zip"
  name "Pour"
  desc "Menu bar Pomodoro for Todoist with a floating liquid-glass card"
  homepage "https://github.com/iammayron/pour"

  # Unsigned (no Apple Developer ID). Homebrew 6 dropped --no-quarantine,
  # so the quarantine flag is stripped after install.
  auto_updates false
  depends_on macos: :sonoma

  app "Pour.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pour.app"]
  end

  zap trash: [
    "~/Library/Application Support/Pour",
    "~/Library/Caches/com.mayron.pour",
    "~/Library/HTTPStorages/com.mayron.pour",
    "~/Library/HTTPStorages/com.mayron.pour.binarycookies",
    "~/Library/Preferences/com.mayron.pour.plist",
    "~/Library/Saved Application State/com.mayron.pour.savedState",
  ]

  caveats <<~EOS
    Pour is not signed with an Apple Developer ID. The quarantine flag is
    removed on install. If macOS still blocks launch, run:
      xattr -dr com.apple.quarantine "#{appdir}/Pour.app"
  EOS
end
