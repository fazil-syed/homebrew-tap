# Homebrew cask for kindle-widget.
# Manually maintained (not GoReleaser). Update version + sha256 per release:
#   shasum -a 256 dist/kindle-widget_<ver>_Darwin_all.tar.gz
cask "kindle-widget" do
  version "0.1.0"

  sha256 "538c2a82353291808e475ded32a79975b0e3abfe367b8db297e2274cb6bc8add"

  url "https://github.com/fazil-syed/kindle-widget/releases/download/v#{version}/kindle-widget_#{version}_Darwin_all.tar.gz"
  homepage "https://github.com/fazil-syed/kindle-widget"

  name "kindle-widget"
  desc "Desktop widget showing live Kindle reading progress"
  livecheck do
    url "https://github.com/fazil-syed/kindle-widget/releases/latest"
    strategy :github_latest
  end

  binary "kindle"

  depends_on cask: "ubersicht"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/kindle-progress"]
  end

  caveats <<~EOS
    Finish setup by running:

      kindle widget install

    This adds the widget to your Übersicht desktop widgets. Drag the card
    to place it, click it to open the Kindle app at your furthest-read page.
    Enable 'Launch at login' in Übersicht's menu-bar item so the widget
    starts on reboot.
  EOS
end
