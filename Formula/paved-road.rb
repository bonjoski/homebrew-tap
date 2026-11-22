# typed: false
# frozen_string_literal: true

# Meta-formula for the 60-second bonjoski local developer security paved road
# (RFC-2026-11-22-44 UB-CLI-v2 & RFC-2026-11-22-48 Portable Paved-Road Pipeline).
# Strictly local, single-developer workstation DevEx — zero cloud control plane.
class PavedRoad < Formula
  desc "Single-command local developer security paved road (bonjoski sovereign toolchain)"
  homepage "https://github.com/bonjoski/homebrew-tap"
  url "https://github.com/bonjoski/fabrial/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "0d51a1481f19f8e970909d729a4353334fa1188febffde671880d06399ec7966"
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
        1. fabrial init
        2. locksmith migrate .env
        3. fabrial check --diff --why
    EOS
    doc.install "README.md" if File.exist?("README.md")
  end

  def caveats
    <<~EOS
      💎 bonjoski Sovereign Paved-Road Toolchain installed!

      Start in under 60 seconds (zero YAML required):
        1. Auto-detect your repo stack & AI SDKs (strictly read-only):
           fabrial init

        2. Move plaintext .env keys into Touch ID / TPM keychain:
           locksmith migrate .env

        3. Run the worktree-local PR gate dry-run before pushing:
           fabrial check --diff --why

      Need progressive disclosure on any tool? Append `--why` or run `<tool> explain`.
    EOS
  end

  test do
    assert_predicate pkgshare/"PAVED_ROAD.txt", :exist?
    assert_match "Fabrial Unified Fabric", shell_output("#{Formula["bonjoski/tap/fabrial"].opt_bin}/fabrial --version")
    assert_match "coppermind", shell_output("#{Formula["bonjoski/tap/coppermind"].opt_bin}/coppermind --version 2>&1")
  end
end
