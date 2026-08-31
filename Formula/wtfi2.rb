class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.4.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "cf20fb80e43823d0e0772dec8d26e4153751f3adc44fadbf3b0ed67c5c322c63"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.4.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "a78e7c962d6f56db933a853384e81402b6c1926e6c3d5e7713409f8b47892b59"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "wtfi"
    end
    if OS.mac? && Hardware::CPU.intel?
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
