class Tutimer < Formula
  desc "Terminal speedcubing timer"
  homepage "https://github.com/michalekmatej/TUtimer"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/michalekmatej/homebrew-tutimer/releases/download/v1.1.0/tutimer-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "8b3520017768265856eb8e3de9cde42fd38411dd34a9a0fc5068dadb49089cad"
    else
      odie "tutimer currently ships Homebrew binaries for Apple Silicon only."
    end
  end

  def install
    bin.install "tutimer"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tutimer --version")
  end
end
