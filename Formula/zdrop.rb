class Zdrop < Formula
  desc "IDE-style dropdown autocomplete for zsh, for every command on your PATH"
  homepage "https://github.com/matan1542/zdrop"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.1/zdrop-0.4.1-darwin-arm64.tar.xz"
      sha256 "36320e63b61349d1b55cceba91b73c9d4babe08acfcbca2caa4bf317c001db46"
    else
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.1/zdrop-0.4.1-darwin-x64.tar.xz"
      sha256 "4cd1eb97d4295effd18fb6b42a8ad5566d1559175d370d83159794e33040efcb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.1/zdrop-0.4.1-linux-arm64.tar.xz"
      sha256 "82076acb558e80d8a825c7dcb00aa76534be8e795d96da3b7cd5accb7189c995"
    else
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.1/zdrop-0.4.1-linux-x64.tar.xz"
      sha256 "87eed93beb9c715612a6c583fb8377c5b28ec678e64c38cc9cda841900bf2282"
    end
  end

  def install
    # self-contained: the daemon, the zsh plugin and a bundled Node.js
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/zdrop"
  end

  def caveats
    <<~EOS
      Turn it on (a line in ~/.zshrc and a login item), then open a new terminal tab:
        zdrop setup
      Check the setup any time with: zdrop doctor
    EOS
  end

  test do
    assert_match "checkout", shell_output("#{bin}/zdrop query 'git ch'")
  end
end
