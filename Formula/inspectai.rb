class Inspectai < Formula
  desc "Point at a DOM element and send it to your coding agent"
  homepage "https://github.com/iammayron/inspectai"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/iammayron/inspectai/releases/download/v#{version}/inspectai_darwin_arm64.tar.gz"
      sha256 "6315210d9f8e3dba3e746b0ad92eafdc07de4eee9a4a61bf5afdb97f83dd026d"
    else
      url "https://github.com/iammayron/inspectai/releases/download/v#{version}/inspectai_darwin_amd64.tar.gz"
      sha256 "fc8a7f9de85185d198fc73b34e5ec75b4ccc3c88ece91e817c14abbc2edf3584"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/iammayron/inspectai/releases/download/v#{version}/inspectai_linux_arm64.tar.gz"
      sha256 "ee57bd1ca0da8d9df385796dc047b2518cf5852b2deeeb518976f48cb192b07e"
    else
      url "https://github.com/iammayron/inspectai/releases/download/v#{version}/inspectai_linux_amd64.tar.gz"
      sha256 "e8d9aa713d63e81a267824dad35a966cb2d1e0f51130731726fdd497431713e9"
    end
  end

  head do
    url "https://github.com/iammayron/inspectai.git", branch: "main"
    depends_on "go" => :build
  end

  def install
    if build.head?
      system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/inspectai"
    else
      bin.install "inspectai"
    end
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
