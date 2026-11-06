# typed: false
# frozen_string_literal: true

# Formula for Fabrial (bonjoski/fabrial)
# The Sovereign AI Agent Security Fabric: Airlock, Locksmith, Aegisbox, Argus, Shield, Conjoiner, Stormcage, Soulcaster, Bomhound.
class Fabrial < Formula
  desc "Sovereign AI agent security fabric orchestrating the bonjoski security toolchain"
  homepage "https://github.com/bonjoski/fabrial"
  url "https://github.com/bonjoski/fabrial/archive/refs/tags/v0.5.5.tar.gz"
  sha256 "f176a174c720531500c93ab5a29df069cc27587816bd74e72210b324aca5758f"
  license "Apache-2.0"
  head "https://github.com/bonjoski/fabrial.git", branch: "main"

  depends_on "go" => :build

  # Sovereign AI Security & Supply-Chain Pillars
  depends_on "bonjoski/tap/airlock"
  depends_on "bonjoski/tap/locksmith"
  depends_on "bonjoski/tap/aegisbox"
  depends_on "bonjoski/tap/argus"
  depends_on "bonjoski/tap/shield"
  depends_on "bonjoski/tap/conjoiner"
  depends_on "bonjoski/tap/stormcage"
  depends_on "bonjoski/tap/soulcaster"
  depends_on "bonjoski/tap/bomhound"

  on_linux do
    depends_on "bubblewrap"
  end

  def install
    ldflags = %W[
      -s -w
      -X github.com/bonjoski/fabrial/pkg/version.Version=#{version}
      -X github.com/bonjoski/fabrial/pkg/version.Commit=brew
      -X github.com/bonjoski/fabrial/pkg/version.BuildTime=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(output: bin/"fabrial", ldflags: ldflags.join(" ")), "./cmd/fabrial"
  end

  def caveats
    <<~EOS
      💎 Fabrial Sovereign AI Security Fabric has been installed!

      To inspect the health and socket status of all 9 security tools:
        fabrial doctor

      To automatically repair misconfigured permissions or stale sockets:
        fabrial doctor --fix

      To initialize an ambient multi-agent session with amortized biometrics:
        eval $(fabrial session begin)

      To check active subagent sessions and microVM queue status:
        fabrial session status
    EOS
  end

  test do
    assert_match "Fabrial Unified Fabric", shell_output("#{bin}/fabrial version")
    assert_match "Diagnostic Suite", shell_output("#{bin}/fabrial doctor")
  end
end
