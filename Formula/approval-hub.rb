class ApprovalHub < Formula
  desc "Aggregate Claude Code permission prompts into one TUI"
  homepage "https://github.com/kanywst/approval-hub"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/kanywst/approval-hub/releases/download/v0.0.1/approval-hub_darwin_arm64.tar.gz"
      sha256 "8b035ec9879d39dae852213eea05c26a1c8ac725c31bd4420a2004aa4265c729"
    end
    on_intel do
      url "https://github.com/kanywst/approval-hub/releases/download/v0.0.1/approval-hub_darwin_amd64.tar.gz"
      sha256 "47465cb309bbab6343b9014a99638d0562ca4d80f02512084449f43c6286e83e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kanywst/approval-hub/releases/download/v0.0.1/approval-hub_linux_arm64.tar.gz"
      sha256 "d5b645334c610e6fa11d0221653b1e8b0c76af57bd22a3554d6e0585ebfb377d"
    end
    on_intel do
      url "https://github.com/kanywst/approval-hub/releases/download/v0.0.1/approval-hub_linux_amd64.tar.gz"
      sha256 "dcfedb81a1b7a0ea26b745f0ccc4e654e84ec8c5fad8d0e5a903d0cc80534684"
    end
  end

  def install
    bin.install "approval-hub"
  end

  test do
    system "#{bin}/approval-hub", "--help"
  end
end
