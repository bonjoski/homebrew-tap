# typed: false
# frozen_string_literal: true

class Aegisbox < Formula
  desc "Unbreakable AI Execution Sandbox & Adversarial Range Engine"
  homepage "https://github.com/bonjoski/aegisbox"
  url "https://github.com/bonjoski/aegisbox/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "860d26965ac9493004c885f5fa8fe30c0b93f1ba3754a7e49c1d20cad1e6ae20"
  license "MIT"
  head "https://github.com/bonjoski/aegisbox.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/bonjoski/aegisbox/pkg/version.Version=#{version}"

    # Core Go binaries (built from uniform v#{version} source)
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/aegisbox"
    system "go", "build", *std_go_args(output: bin/"aegisboxd", ldflags: ldflags), "./cmd/aegisboxd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-netd", ldflags: ldflags), "./cmd/aegisbox-netd"
    system "go", "build", *std_go_args(output: bin/"aegisbox-guest", ldflags: ldflags), "./cmd/aegisbox-guest"
    system "go", "build", *std_go_args(output: bin/"aegisbox-spiffe-agent", ldflags: ldflags), "./cmd/aegisbox-spiffe-agent"
  end

  def caveats
    <<~EOS
      Aegisbox MicroVM engine (#{version}) has been installed!

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
  end
end
