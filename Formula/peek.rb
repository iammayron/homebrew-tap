class Peek < Formula
  desc "Point at a DOM element and send it to your coding agent"
  homepage "https://github.com/iammayron/peek"
  license "MIT"

  head do
    url "https://github.com/iammayron/peek.git", branch: "main"
    depends_on "go" => :build
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iammayron/peek/releases/download/v0.2.2/peek_darwin_arm64.tar.gz"
      sha256 "651d371179a1f3f5d2f3d332047fabcd8c05b4a9ad8f3761e104e99570db48f7"
    else
      url "https://github.com/iammayron/peek/releases/download/v0.2.2/peek_darwin_amd64.tar.gz"
      sha256 "7252c4404d32112d4760b52cce1282d2496522da3c0112601b1c14f96cd423c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iammayron/peek/releases/download/v0.2.2/peek_linux_arm64.tar.gz"
      sha256 "170b281a7dba842699b9df42786e28a353bb3fc2f34ab8f0c45b1e7c7c1e23e9"
    else
      url "https://github.com/iammayron/peek/releases/download/v0.2.2/peek_linux_amd64.tar.gz"
      sha256 "7729fc797315db3a7c6066f0a0f25bc5df6d66a71a520e3548aea463930f4d5b"
    end
  end

  def install
    if build.head?
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/peek"
    else
      bin.install "peek"
    end
  end

  def caveats
    <<~EOS
      Register the daemon, MCP server, and agent skills:

        peek install

      Then install the extension from the Chrome Web Store:

        https://chromewebstore.google.com/detail/peek/afalnlminndnlfgnlphbelelpcblcbld

      Press Alt+Shift+P, click an element, then tell your agent "look at this".
      `peek doctor` reports the daemon, extension, and last pin.
    EOS
  end

  test do
    assert_match "peek", shell_output("#{bin}/peek version")
  end
end
