class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.0/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "3954314de0f58d15197070b5986c2d6881a8178620f742120e97449e57ef05cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.0/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "c36d7ec57c0996d0086026d66b438275291a676cfa3e4d536e00ff22f27983ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.0/wtfi2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "681f3d3b1db53ac4a88a6707a87adb9cc975c36f550654ce30a5bbc726fd3d56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.0/wtfi2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cc38559d9d7718c59f0fb575945dbb245b04ab164b39c3c29eb7a858494e3d2b"
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
