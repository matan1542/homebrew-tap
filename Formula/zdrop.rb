class Zdrop < Formula
  desc "Kiro-style dropdown autocomplete for zsh, for every command on your PATH"
  homepage "https://github.com/matan1542/zdrop"
  version "0.3.1"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/matan1542/zdrop/releases/download/v0.3.1/zdrop-0.3.1-darwin-arm64.tar.xz"
    sha256 "96742a32d69692150c44a08e569016b202896c7753b13a348e2f8fd255c4867f"
  else
    url "https://github.com/matan1542/zdrop/releases/download/v0.3.1/zdrop-0.3.1-darwin-x64.tar.xz"
    sha256 "c3700af5c795f00ab800b1bc1b2adcb82accaeadacaf637120b2bee63eeb2286"
  end

  depends_on :macos

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
