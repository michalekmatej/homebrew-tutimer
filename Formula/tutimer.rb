class Tutimer < Formula
  desc "Terminal speedcubing timer"
  homepage "https://github.com/michalekmatej/TUtimer"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/michalekmatej/homebrew-tutimer/releases/download/v1.3.0/tutimer-1.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "041d6e02e47558ae21dca54db72cf858335f366addf07b10bf6f981feaeaa52d"
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
