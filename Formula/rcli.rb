# rcli Homebrew formula template.
#
# Rendered by rcli/scripts/update-tap.sh after a GitHub release
# publishes the platform tarballs: 0.20.24, 871b5544e5c6837975116dd05cf33d561a98a72d4940a162752f4abf958a3296 and
# cb02714089e9ceedde45e3d1465bc9447167fb4b462dcb8c679d8c906b2aa3f4 are substituted from the release's .sha256 sidecars,
# then the result is committed to the RunanywhereAI/homebrew-tap repository as
# Formula/rcli.rb (`brew install runanywhereai/tap/rcli`).
class Rcli < Formula
  desc "RunAnywhere on-device AI CLI — run, manage and serve local models"
  homepage "https://github.com/RunanywhereAI/runanywhere-sdks"
  version "0.20.24"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/RunanywhereAI/runanywhere-sdks/releases/download/v0.20.24/rcli-macos-arm64-v0.20.24.tar.gz"
      sha256 "871b5544e5c6837975116dd05cf33d561a98a72d4940a162752f4abf958a3296"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/RunanywhereAI/runanywhere-sdks/releases/download/v0.20.24/rcli-linux-x86_64-v0.20.24.tar.gz"
      sha256 "cb02714089e9ceedde45e3d1465bc9447167fb4b462dcb8c679d8c906b2aa3f4"
    end
    depends_on "curl"
  end

  def install
    # Keep the executable colocated with its MLX metallib and SwiftPM resource
    # bundles. The Linux archive contains only rcli here, so the same layout is
    # harmless across both platforms.
    libexec.install Dir["bin/*"]
    bin.install_symlink libexec/"rcli"
    lib.install Dir["lib/*"] unless Dir["lib/*"].empty?
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Models are stored under ~/.local/share/runanywhere (override with
      RUNANYWHERE_HOME). Get started:
        rcli list --all
        rcli run qwen3
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rcli version")
    system bin/"rcli", "backends"
  end
end
