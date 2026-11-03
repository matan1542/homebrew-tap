class Zdrop < Formula
  desc "Kiro-style dropdown autocomplete for zsh, for every command on your PATH"
  homepage "https://github.com/matan1542/zdrop"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.0/zdrop-0.4.0-darwin-arm64.tar.xz"
      sha256 "ad393e88d81c00443e9051b5a2f7fe720689fc59ef73fe96012fe13c10409c86"
    else
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.0/zdrop-0.4.0-darwin-x64.tar.xz"
      sha256 "c8745f0ec4eed0614c1038d3b94c6fac9390087ea5bcb5d2006b9e7eea3fd0b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.0/zdrop-0.4.0-linux-arm64.tar.xz"
      sha256 "9d72094a0cbda11bb8282333b4937053b9bf8d252fad3b22eed8b64276bcbce3"
    else
      url "https://github.com/matan1542/zdrop/releases/download/v0.4.0/zdrop-0.4.0-linux-x64.tar.xz"
      sha256 "f74eac6d40616cae81e03e7e161eecff8e6c4e1b2b80a0f7e305217db0b9d502"
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
