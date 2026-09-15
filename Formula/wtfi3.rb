class Wtfi3 < Formula
  desc "Visualize who talks to whom on a WiFi network you administer"
  homepage "https://github.com/kanywst/wtfi3"
  url "https://github.com/kanywst/wtfi3/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "3f056bbbdf1c4aa2bd173b08506fa71137d23d63a6c49c2f5599297ec99fd81d"
  license "MIT"
  head "https://github.com/kanywst/wtfi3.git", branch: "main"

  depends_on "go" => :build
  on_linux do
    depends_on "libpcap"
  end

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/wtfi3"
  end

  def caveats
    <<~EOS
      Live capture needs root:
        sudo wtfi3 -i en0
      Offline replay needs no root:
        wtfi3 -r capture.pcap
      Then open http://localhost:8080
    EOS
  end

  test do
    assert_match "wtfi3 #{version}", shell_output("#{bin}/wtfi3 -version")
  end
end
