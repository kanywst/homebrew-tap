class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.3.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "d76fedce28e04d4e6c6e0d68caaa95abc7ec7c213c694cd52f7e6c62e0254654"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.3.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "c0981091b79aa4a74e83a8eecff0dc2f2e4a75d7ca68b7c8beda9ec50b29a2f8"
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
