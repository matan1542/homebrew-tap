class Zdrop < Formula
  desc "Kiro-style dropdown autocomplete for zsh, for every command on your PATH"
  homepage "https://github.com/matan1542/zdrop"
  version "0.2.0"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/matan1542/zdrop/releases/download/v0.2.0/zdrop-0.2.0-darwin-arm64.tar.xz"
    sha256 "4716e3f8b25d9e4a186abc78faac46626a99683fa93d2c0b5349eef8524c7ae9"
  else
    url "https://github.com/matan1542/zdrop/releases/download/v0.2.0/zdrop-0.2.0-darwin-x64.tar.xz"
    sha256 "782da289e079d8d7f094e65c05dfcb787c5aa00084a7e7f18dac665ad9ad4dc8"
  end

  depends_on :macos

  def install
    # self-contained: the daemon, the zsh plugin and a bundled Node.js
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/zdrop"
  end

  def caveats
    <<~EOS
      Add this line to the end of ~/.zshrc, then open a new terminal tab:
        source "#{opt_libexec}/zsh/zdrop.plugin.zsh"
      Check the setup any time with: zdrop doctor
    EOS
  end

  test do
    assert_match "checkout", shell_output("#{bin}/zdrop query 'git ch'")
  end
end
