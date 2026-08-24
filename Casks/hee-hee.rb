cask "hee-hee" do
  version "0.1.0"
  sha256 "aa5f18eda6ff3b7d164f12ed3f1f02ab5368425f29d46f85411158b909a68af7"

  url "https://github.com/notuselessdev/hee-hee/releases/download/v#{version}/hee-hee-#{version}.dmg"
  name "hee-hee"
  desc "Michael Jackson dances across your screen at random intervals"
  homepage "https://github.com/notuselessdev/hee-hee"

  depends_on macos: ">= :ventura"

  app "hee-hee.app"

  zap trash: [
    "~/Library/Preferences/dev.notuseless.hee-hee.plist",
  ]
end
