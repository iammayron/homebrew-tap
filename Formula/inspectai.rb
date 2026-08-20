class Inspectai < Formula
  desc "Point at a DOM element and send it to your coding agent"
  homepage "https://github.com/iammayron/inspectai"
  url "https://github.com/iammayron/inspectai/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "db0e6442ef2f7d28dbb999d25816b6b86a9947ad0f2b5241dadeaaa91970cbc2"
  license "MIT"
  head "https://github.com/iammayron/inspectai.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/inspectai"
  end

  def post_install
    system bin/"inspectai", "install"
  end

  def caveats
    <<~EOS
      InspectAI is on PATH. Load the unpacked extension:

        1. Open chrome://extensions (ego lite: ego://extensions)
        2. Enable Developer mode
        3. Load unpacked from the path printed by `inspectai doctor`

      Shortcut: Alt+Shift+I, click an element, then tell your agent "look at this".
    EOS
  end

  test do
    assert_match "inspectai", shell_output("#{bin}/inspectai version")
  end
end
