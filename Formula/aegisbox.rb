# typed: false
# frozen_string_literal: true

class Aegisbox < Formula
  desc "Unbreakable AI Execution Sandbox & Adversarial Range Engine"
  homepage "https://github.com/bonjoski/aegisbox"
  url "https://github.com/bonjoski/aegisbox/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "52442ff797beaa4e16ea42af270911cb04ccfd663b9458e37e3d6135c60a902f"
  license "Apache-2.0"
  head "https://github.com/bonjoski/aegisbox.git", branch: "main"

  depends_on "go" => :build

  on_macos do
    if Hardware::CPU.arm?
      resource "cockpit-arm64" do
        url "https://github.com/bonjoski/aegisbox/releases/download/v0.8.1/aegisbox-cockpit-darwin-arm64"
        sha256 "4120d300845bcf3ad608b05ae2af19209d91d3e3133b68162799147cd1422366"
      end
    end
  end

  def install
    ldflags = "-s -w -X github.com/bonjoski/aegisbox/pkg/version.Version=#{version}"

    # Core Go binaries (built from uniform v#{version} source)
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/aegisbox"
    system "go", "build", *std_go_args(output: bin/"aegisboxd", ldflags: ldflags), "./cmd/aegisboxd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-netd", ldflags: ldflags), "./cmd/aegisbox-netd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-guest", ldflags: ldflags), "./cmd/aegisbox-guest"
    system "go", "build", *std_go_args(output: bin/"aegisbox-spiffe-agent", ldflags: ldflags), "./cmd/aegisbox-spiffe-agent"

    # Install desktop cockpit on macOS ARM64
    if OS.mac? && Hardware::CPU.arm?
      resource("cockpit-arm64").stage do
        bin.install "aegisbox-cockpit-darwin-arm64" => "aegisbox-cockpit"
      end
    end
  end

  def caveats
    <<~EOS
      Aegisbox MicroVM engine (#{version}) and Cockpit have been installed!

      To launch the Aegisbox Cockpit GUI:
        aegisbox cockpit

      NOTE (macOS Hardware Hypervisor Entitlements):
        Apple Virtualization.framework / Hypervisor.framework requires binaries
        invoking hardware microVMs (`aegisbox`, `aegisboxd`) to carry the
        `com.apple.security.virtualization` / `com.apple.security.hypervisor`
        entitlements (distributed via signed `.app` bundle or local codesign).
    EOS
  end

  test do
    assert_match "aegisbox version", shell_output("#{bin}/aegisbox version")
    assert_path_exists bin/"aegisboxd"
    assert_path_exists bin/"aegisbox-spiffe-agent"
    assert_path_exists bin/"aegisbox-cockpit" if OS.mac? && Hardware::CPU.arm?
  end
end
