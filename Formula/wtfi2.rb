class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.10.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "d26f874e5196d9ac8522f886eb78a98c0e08ef5f41a7f6114b882251abe0e048"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.10.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "1d1de00ed2a17592767b0acbdc4a226aff84c3c4df317e9d2d8591a2c995973e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.10.0/wtfi2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ce3558083c5d833c8936dac678e1fa657823ab39d95822c355acaba518603f58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.10.0/wtfi2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "783c9247e63edf7d009f121a0180fd954a931298deda0c6b3256f561b353a332"
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
