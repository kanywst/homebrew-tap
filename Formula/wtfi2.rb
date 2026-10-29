class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.8.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "a763a3d3528d457e908805af15531d0123a26fad60e0e1f105a174fda09a3bb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.8.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "8f0c75b000e0c0dba63c00c76980a59c852c2040b9f8fee17ef1a14465c6d474"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.8.0/wtfi2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a485cb089ae0a42a95d69d84e4a00dc8d4a607252e3f429da4beb4c28edbc4c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.8.0/wtfi2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0d675d9200200b394cf906deb1ea12cce938f357c4f757cbd38da9ea88c654a2"
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
