cask "zero" do
  version "0.1.0"
  sha256 :no_check # Replace with actual SHA256 once you have a release

  url "https://github.com/kanywst/zero/releases/download/v#{version}/ZeroEditor_#{version}_aarch64.dmg"
  name "Zero"
  desc "Hyper-fast, Markdown editor built with Rust and React"
  homepage "https://github.com/kanywst/zero"

  app "ZeroEditor.app"

  zap trash: [
    "~/Library/Application Support/com.kanywst.zero",
    "~/Library/Preferences/com.kanywst.zero.plist",
    "~/Library/Saved Application State/com.kanywst.zero.savedState",
  ]
end
