class Tutimer < Formula
  desc "Terminal speedcubing timer"
  homepage "https://github.com/michalekmatej/TUtimer"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/michalekmatej/homebrew-tutimer/releases/download/v1.2.0/tutimer-1.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "2a7e23c41f8f0621526fc6f56a09311d304da1921a7e5ee6bc672d3a3007598a"
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
