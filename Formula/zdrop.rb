class Zdrop < Formula
  desc "Kiro-style dropdown autocomplete for zsh, for every command on your PATH"
  homepage "https://github.com/matan1542/zdrop"
  version "0.2.2"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/matan1542/zdrop/releases/download/v0.2.2/zdrop-0.2.2-darwin-arm64.tar.xz"
    sha256 "19033c7de1034d93e45b3cb20fd3a81290e3be430f6ec394cfa3773f30ceeabb"
  else
    url "https://github.com/matan1542/zdrop/releases/download/v0.2.2/zdrop-0.2.2-darwin-x64.tar.xz"
    sha256 "d471fffd155f1cb437cc4a9748c9e182ab1b8832bb0d7de258d7d45a6f77ada6"
  end

  depends_on :macos

  def install
    # self-contained: the daemon, the zsh plugin and a bundled Node.js
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/zdrop"
  end

  def caveats
    <<~EOS
      Turn it on (adds one line to the end of ~/.zshrc), then open a new terminal tab:
        zdrop setup
      Check the setup any time with: zdrop doctor
    EOS
  end

  test do
    assert_match "checkout", shell_output("#{bin}/zdrop query 'git ch'")
  end
end
