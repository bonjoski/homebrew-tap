# bonjoski/homebrew-tap

Official Homebrew tap for the Bonjoski sovereign AI agent security ecosystem.

> [!NOTE]
> **Developer Tooling & Safe Harbor Scope**: All formulas in this tap distribute personal developer workstation utilities running strictly on localhost with zero multi-tenant cloud control planes or commercial enterprise AI runtime security features.

This tap provides formulas for:
- **[Paved-Road (`paved-road`)](Formula/paved-road.rb)** – Single-command meta-formula installing the complete 60-second local developer toolchain.
- **[Fabrial](https://github.com/bonjoski/fabrial)** – Sovereign AI agent security fabric unifying Airlock, Locksmith, Aegisbox, and Argus (`fabrial init`, `fabrial check --diff`).
- **[Aegisbox](https://github.com/bonjoski/aegisbox)** – MicroVM confinement hypervisor, desktop cockpit, and adversarial range engine.
- **[Airlock](https://github.com/bonjoski/airlock)** – Zero-trust workstation sandbox for untrusted package installs & agentic AI loops.
- **[Argus](https://github.com/bonjoski/argus)** – Pre-flight dependency validator and local typosquatting package scanner.
- **[Bomhound](https://github.com/bonjoski/bomhound)** – High-performance SBOM copyright & legal provenance enrichment engine.
- **[Coppermind](https://github.com/bonjoski/coppermind)** – Local-first AI memory system and security mentor capsule engine for coding agents.
- **[Conjoiner](https://github.com/bonjoski/conjoiner)** – Deterministic tool gateway and RFC 9449 DPoP reference library for local agent CLI tools.
- **[Soulcaster](https://github.com/bonjoski/soulcaster)** – Sovereign compiler wrapper and in-toto provenance attestation engine.
- **[Tinmind](https://github.com/bonjoski/tinmind)** – Sovereign local PTY flight recorder and deterministic Safe-ANSI TTY replay for coding agents.
- **[Oathgate](https://github.com/bonjoski/oathgate)** – Instant Copy-on-Write time-travel workspace checkpoints (`clonefile(2)` / `FICLONE`) for coding agents.
- **[Locksmith](https://github.com/bonjoski/locksmith)** – Secure macOS keychain-backed secrets manager with Touch ID / Apple Watch biometric authentication and desktop cockpit.

---

## ⚡ 60-Second Paved-Road Install (Single Command)

Install the entire local sovereign toolchain in one step — zero YAML files, zero cloud control plane:

### Option A: Single-Command Meta-Formula
```bash
brew tap bonjoski/tap
brew install bonjoski/tap/paved-road
```

### Option B: Homebrew Bundle (`Brewfile.paved-road`)
```bash
brew bundle --file=Brewfile.paved-road
```

### Verify & Protect Any Repo in <60 Seconds
```bash
# 1. Read-only stack & AI SDK detection (0 YAML written)
fabrial init

# 2. Move plaintext .env keys into Touch ID / TPM keychain and shred disk plaintext
locksmith migrate .env

# 3. Preview proven diff-only PR checks locally (zero Touch ID prompts, N=8 worktree safe)
fabrial check --diff --why
```

---

## 🚀 Individual Formula Installation

Tap the repository:
```bash
brew tap bonjoski/tap
```

Install Fabrial (or individual tools):
```bash
brew install bonjoski/tap/fabrial
brew install bonjoski/tap/aegisbox
brew install bonjoski/tap/airlock
brew install bonjoski/tap/argus
brew install bonjoski/tap/conjoiner
brew install bonjoski/tap/soulcaster
brew install bonjoski/tap/bomhound
brew install bonjoski/tap/coppermind
brew install bonjoski/tap/tinmind
brew install bonjoski/tap/oathgate
brew install bonjoski/tap/locksmith
```
