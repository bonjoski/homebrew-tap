# typed: false
# frozen_string_literal: true

class Aegisbox < Formula
  desc "Unbreakable AI Execution Sandbox & Adversarial Range Engine"
  homepage "https://github.com/bonjoski/aegisbox"
  url "https://github.com/bonjoski/aegisbox/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "789742e1b760ebaa0d3e490eabba2c3bf01e7d5a67d48d0d9e6579519e413e30"
  license "MIT"
  head "https://github.com/bonjoski/aegisbox.git", branch: "main"

  depends_on "go" => :build

  on_macos do
    if Hardware::CPU.arm?
      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/aegisbox/releases/download/v0.5.3/aegisbox-cockpit-darwin-arm64"
        sha256 "e182956dfac43bcb2c75d789a39d67c8dcf7806d3f1f9903a5a8da5645314e2d"
      end
    end
  end

  def install
    # Core Go binaries
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/aegisbox"
    system "go", "build", *std_go_args(output: bin/"aegisboxd", ldflags: "-s -w"), "./cmd/aegisboxd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-netd", ldflags: "-s -w"), "./cmd/aegisbox-netd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-guest", ldflags: "-s -w"), "./cmd/aegisbox-guest"
    system "go", "build", *std_go_args(output: bin/"aegisbox-spiffe-agent", ldflags: "-s -w"), "./cmd/aegisbox-spiffe-agent"

    # Install desktop cockpit on macOS
    if OS.mac? && Hardware::CPU.arm?
      resource("cockpit-arm64").stage do
        bin.install "aegisbox-cockpit-darwin-arm64" => "aegisbox-cockpit"
      end
    end
  end

  def caveats
    <<~EOS
      Aegisbox MicroVM engine and Cockpit have been installed!

      To launch the Aegisbox Cockpit GUI:
        aegisbox cockpit
    EOS
  end

  test do
    assert_match "aegisbox version", shell_output("#{bin}/aegisbox version")
    assert_path_exists bin/"aegisboxd"
    assert_path_exists bin/"aegisbox-spiffe-agent"
    if OS.mac? && Hardware::CPU.arm?
      assert_path_exists bin/"aegisbox-cockpit"
    end
  end
end
