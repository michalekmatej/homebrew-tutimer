class Tutimer < Formula
  desc "Terminal speedcubing timer"
  homepage "https://github.com/michalekmatej/TUtimer"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/michalekmatej/homebrew-tutimer/releases/download/v1.0.0/tutimer-1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "ab2cc33e28a80db93d62220335451b5a37938c2b3d55765a2dff066f8aa1d2d9"
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
