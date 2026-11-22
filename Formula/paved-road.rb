# typed: false
# frozen_string_literal: true

# Meta-formula for the 60-second bonjoski local developer security paved road
# (RFC-2026-11-22-44 UB-CLI-v2 & RFC-2026-11-22-48 Portable Paved-Road Pipeline).
# Strictly local, single-developer workstation DevEx — zero cloud control plane.
class PavedRoad < Formula
  desc "Single-command local developer security paved road (bonjoski sovereign toolchain)"
  homepage "https://github.com/bonjoski/homebrew-tap"
  url "https://github.com/bonjoski/fabrial/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "2ea3df886b9d45b20153c6210092caa3295ebc23fd96397f49b375f96e808a50"
  license "Apache-2.0"

  # Full Sovereign Local Workstation Toolchain
  depends_on "bonjoski/tap/fabrial"
  depends_on "bonjoski/tap/airlock"
  depends_on "bonjoski/tap/aegisbox"
  depends_on "bonjoski/tap/argus"
  depends_on "bonjoski/tap/locksmith"
  depends_on "bonjoski/tap/soulcaster"
  depends_on "bonjoski/tap/bomhound"
  depends_on "bonjoski/tap/shield"
  depends_on "bonjoski/tap/stormcage"
  depends_on "bonjoski/tap/conjoiner"
  depends_on "bonjoski/tap/coppermind"

  def install
    (pkgshare/"PAVED_ROAD.txt").write <<~EOS
      bonjoski Sovereign Local Paved Road (UB-CLI-v2)
      Scope: 100% local single-developer workstation DevEx (zero cloud control plane).

      60-Second Onboarding:
        1. fabrial init --mcp --apply
        2. locksmith migrate .env
        3. eval "$(fabrial session begin)"
        4. fabrial check --diff --why && fabrial receipt verify
    EOS
    doc.install "README.md" if File.exist?("README.md")
  end

  def caveats
    <<~EOS
      💎 bonjoski Sovereign Paved-Road Toolchain installed!

      Start in under 60 seconds (zero YAML required):
        1. Auto-detect your repo stack & wire IDE MCP servers (dry-run first, then --apply):
           fabrial init --mcp
           fabrial init --mcp --apply

        2. Move plaintext .env keys into Touch ID / TPM keychain:
           locksmith migrate .env

        3. Start an amortized local session (1 Touch ID prompt, 0ms runtime wrapper hop tax):
           eval "$(fabrial session begin)"

        4. Run the worktree-local PR gate dry-run & verify signed BLPR-v1 receipts:
           fabrial check --diff --why && fabrial receipt verify

      Need progressive disclosure on any tool? Append `--why` or run `<tool> explain`.
      macOS Touch ID entitlements: if you need codesigned biometric binaries, install
      `bonjoski/locksmith/locksmith` from the dedicated codesigned tap.
    EOS
  end

  test do
    assert_predicate pkgshare/"PAVED_ROAD.txt", :exist?
    assert_match "Fabrial Unified Fabric", shell_output("#{Formula["bonjoski/tap/fabrial"].opt_bin}/fabrial --version")
    assert_match "coppermind", shell_output("#{Formula["bonjoski/tap/coppermind"].opt_bin}/coppermind --version 2>&1")
    assert_match "argus", shell_output("#{Formula["bonjoski/tap/argus"].opt_bin}/argus --version 2>&1")
  end
end
