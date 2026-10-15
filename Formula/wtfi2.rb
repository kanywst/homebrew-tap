class Wtfi2 < Formula
  desc "What The F*ck Internet — a live, visual network path diagnostic that pinpoints exactly where your connection dies."
  homepage "https://github.com/kanywst/wtfi2"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.1/wtfi2-aarch64-apple-darwin.tar.xz"
      sha256 "f6939f87266f7d34c405a7dea04cbfc18e161cb52714126644450818fe479d6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.1/wtfi2-x86_64-apple-darwin.tar.xz"
      sha256 "9924fa157f5db8595e71b776c8a8e437d221e54eadaa6703f046aca7f16cc2af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.1/wtfi2-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9164450484623dccde80f893faf13d4f870676426a1051f8bcada5bb588c4a27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kanywst/wtfi2/releases/download/v0.6.1/wtfi2-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dc6291c041945f60424cf8a48e68f810ecc98397a9de27850c155e48a0715a13"
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
