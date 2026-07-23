class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.2.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "7696530f9cc84db967898ac2bd808100d0135ad724c0329e450e5e2b5c7dbf81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.2.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "4e367f3e27f7be52fbda54f50d7461af8de1664416f52723ea7543d6134a9779"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
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
    bin.install "wtfi" if OS.mac? && Hardware::CPU.arm?
    bin.install "wtfi" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
