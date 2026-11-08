# Homebrew cask for kindle-widget.
# Manually maintained (not GoReleaser). Update version + sha256 per release.
# IMPORTANT: the sha256 must come from the GitHub release asset itself
# (curl the file, shasum it) — the CI-built tarball is the source of truth
# and differs byte-wise from any local ./build.sh output (gzip timestamps).
#   curl -L <asset-url> | shasum -a 256
cask "kindle-widget" do
  version "0.1.0"

  sha256 "a5603a2f51dbec5ff8d8e6194aeed4352a330f4c1e10360d9c66e402e62d33a1"

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
