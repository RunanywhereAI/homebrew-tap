# rcli Homebrew formula template.
#
# Rendered by sdk/runanywhere-cli/scripts/update-tap.sh after a GitHub release
# publishes the platform tarballs: 0.20.10, f354deac0c544d771c52e2c1a3e1efe99b5fe923b4d2d45ae11349bebd387e9a and
# cead27def38c2252487ce4da187233074cd351d38c196e2a0b149328cc1e6bcf are substituted from the release's .sha256 sidecars,
# then the result is committed to the RunanywhereAI/homebrew-tap repository as
# Formula/rcli.rb (`brew install runanywhere-ai/tap/rcli`).
class Rcli < Formula
  desc "RunAnywhere on-device AI CLI — run, manage and serve local models"
  homepage "https://github.com/RunanywhereAI/runanywhere-sdks"
  version "0.20.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/RunanywhereAI/runanywhere-sdks/releases/download/v0.20.10/rcli-macos-arm64-v0.20.10.tar.gz"
      sha256 "f354deac0c544d771c52e2c1a3e1efe99b5fe923b4d2d45ae11349bebd387e9a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/RunanywhereAI/runanywhere-sdks/releases/download/v0.20.10/rcli-linux-x86_64-v0.20.10.tar.gz"
      sha256 "cead27def38c2252487ce4da187233074cd351d38c196e2a0b149328cc1e6bcf"
    end
    depends_on "curl"
  end

  def install
    bin.install "bin/rcli"
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
