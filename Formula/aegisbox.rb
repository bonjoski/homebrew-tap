# typed: false
# frozen_string_literal: true

class Aegisbox < Formula
  desc "Unbreakable AI Execution Sandbox & Adversarial Range Engine"
  homepage "https://github.com/bonjoski/aegisbox"
  url "https://github.com/bonjoski/aegisbox/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "c1b6fbcd8da0e8feb7bdad71e1d4cb560d163670db6c6390dd6d2d10fc97a5e3"
  license "MIT"
  head "https://github.com/bonjoski/aegisbox.git", branch: "main"

  depends_on "go" => :build

  on_macos do
    if Hardware::CPU.arm?
      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/aegisbox/releases/download/v0.5.2/aegisbox-cockpit-darwin-arm64"
        sha256 "9a79001083a686ef713a18f85f01a0f00dc0be97a8336e11007fc8c1f3791759"
      end
    end
  end

  def install
    # Core Go binaries
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/aegisbox"
    system "go", "build", *std_go_args(output: bin/"aegisboxd", ldflags: "-s -w"), "./cmd/aegisboxd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-netd", ldflags: "-s -w"), "./cmd/aegisbox-netd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-guest", ldflags: "-s -w"), "./cmd/aegisbox-guest"

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
    if OS.mac? && Hardware::CPU.arm?
      assert_path_exists bin/"aegisbox-cockpit"
    end
  end
end
