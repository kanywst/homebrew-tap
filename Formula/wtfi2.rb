class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.7.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "72ef4a605c6e4224399ae756b66c94703c1c2c7577c880745dbdad68d8195a0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.7.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "336ecf8cc4ec47e622370eea371bbfb56bbd204df2f627724cd017dee9110f1e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.7.0/wtfi2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "613ef06797ca8bbf74bfd04167055a2c9228e33be3e267df7852d5c9e86edefd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.7.0/wtfi2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6c61f166e2d575eab58c2368b84c4c4def4c5264042518013edb88a24200baf"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "wtfi"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "wtfi"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "wtfi"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "wtfi"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
