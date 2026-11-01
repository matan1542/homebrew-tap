class Zdrop < Formula
  desc "Kiro-style dropdown autocomplete for zsh, for every command on your PATH"
  homepage "https://github.com/matan1542/zdrop"
  version "0.2.1"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/matan1542/zdrop/releases/download/v0.2.1/zdrop-0.2.1-darwin-arm64.tar.xz"
    sha256 "01e3e56aea19e053969886c9d9807822fae23a03b85febd1ca3ebfc9384446fd"
  else
    url "https://github.com/matan1542/zdrop/releases/download/v0.2.1/zdrop-0.2.1-darwin-x64.tar.xz"
    sha256 "4c89437ea1f3c64cf97843137fefba818bfd00928b9064013ed8a0de678f672e"
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
