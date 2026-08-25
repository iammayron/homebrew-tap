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
      url "https://github.com/iammayron/peek/releases/download/v0.2.1/peek_darwin_arm64.tar.gz"
      sha256 "f7839ea0908c5148e8d07a9ad1d5e1c58c6a4999209031952e4cad089f98e2d6"
    else
      url "https://github.com/iammayron/peek/releases/download/v0.2.1/peek_darwin_amd64.tar.gz"
      sha256 "1b5bd15911b644decffc496879961209b01527919d13ca42a8cc0e0fc4d779bb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iammayron/peek/releases/download/v0.2.1/peek_linux_arm64.tar.gz"
      sha256 "991e3d66ebeec6f189d139fa4d44131e0411fbe1701b1e31af53e1fbe4799a0e"
    else
      url "https://github.com/iammayron/peek/releases/download/v0.2.1/peek_linux_amd64.tar.gz"
      sha256 "7b372fbcafc27f068b12840d6bf395e2a567bd4578f5814a1221a1ba32d96366"
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
