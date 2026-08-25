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
      url "https://github.com/iammayron/peek/releases/download/v0.2.3/peek_darwin_arm64.tar.gz"
      sha256 "1ee0574989d3f7a32295fc9f09ea0bba636195d648c957e8edb57b3e5244c810"
    else
      url "https://github.com/iammayron/peek/releases/download/v0.2.3/peek_darwin_amd64.tar.gz"
      sha256 "aa091c053948a2c91914573591e1e2b808af86e2343d0fd1ad685ba1fd391b08"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iammayron/peek/releases/download/v0.2.3/peek_linux_arm64.tar.gz"
      sha256 "eca695f93a889da06711808a5927f1e1254a36a944d2ad34e7e87624a099ab1b"
    else
      url "https://github.com/iammayron/peek/releases/download/v0.2.3/peek_linux_amd64.tar.gz"
      sha256 "3117390ec61d25fc27a6bb9b21823be30731d370af00ed632ad64992fb02d9a6"
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
