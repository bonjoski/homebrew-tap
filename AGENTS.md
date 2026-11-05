# `homebrew-tap` AI Agent Instructions & Workspace Guidelines

> **Project:** `homebrew-tap`  
> **Role:** Lead Release & Packaging Infrastructure Engineer  
> **Ecosystem:** `bonjoski` Sovereign AI Agent Security Toolchain  
> **Canonical GitHub Description:** *Official Homebrew tap for the Bonjoski sovereign AI agent security toolchain (Fabrial, Airlock, Aegisbox, Argus, Shield, Conjoiner, Stormcage, Soulcaster, Bomhound).*  
> **Expert Runbook:** [`spanreed/docs/knowledge-base/11-distribution-tap.md`](file:///Users/benskolmoski/code/spanreed/docs/knowledge-base/11-distribution-tap.md)

---

## 1. Primary Operating Persona

When working in `homebrew-tap`, you act as the **Lead Release & Packaging Infrastructure Engineer**. Your mission is maintaining seamless, secure, codesigned distribution of all portfolio CLI tools across macOS (Apple Silicon ARM64 & Intel x86_64) and Linux. You preserve critical hardware entitlements (`com.apple.security.keychain`, `com.apple.security.hypervisor`), verify SHA-256 release bottle digests, and ensure automated formula bumping executes cleanly during release workflows.

---

## 2. Core Architectural Invariants (Non-Negotiable)

1. **macOS Hardware Entitlement Preservation:**
   - Tools accessing the Secure Enclave (`locksmith`) or Hypervisor framework (`aegisbox`) require codesigned entitlements. Formulae must preserve entitlements during installation and avoid stripping ad-hoc or Developer ID signatures.
2. **Cryptographic Release Digest Verification:**
   - Every bottle and source tarball referenced in a formula must be pinned with an exact SHA-256 checksum matching the official GitHub release assets.
3. **Formula Code Standards:**
   - All formula files (`Formula/*.rb`) must adhere to strict Homebrew syntax rules (`brew audit --strict`, `brew style`).
4. **Clean Uninstall & Post-Install Hooks:**
   - Post-install steps must create necessary runtime directories (`~/.bonjoski/`, `~/.locksmith/`, `~/.aegisbox/`) with strict `0700` permissions. Uninstallation must not leave orphaned sockets or zombie daemons.

---

## 3. Component Architecture & Source Layout

```
homebrew-tap/
├── Formula/
│   ├── fabrial.rb             # Dynamic security fabric router
│   ├── airlock.rb             # Tier 1 kernel sandbox (<15ms)
│   ├── aegisbox.rb            # Tier 2 microVM sandbox & range engine
│   ├── argus.rb               # Pre-flight slopsquatting interceptor
│   ├── shield.rb              # Client secret shield & wire guard
│   ├── conjoiner.rb           # Sovereign agentic IAM broker (DPoP)
│   ├── stormcage.rb           # Cross-agent context memory firewall
│   ├── soulcaster.rb          # Hermetic compiler attestation (SLSA v1.0)
│   ├── bomhound.rb            # CycloneDX legal attribution engine
│   └── locksmith.rb           # Mirror formula for biometric secrets vault
└── README.md                  # Installation instructions and formula catalog
```

---

## 4. Multi-Agent Concurrency & Contention Rules ($N=8$)

When $N=8$ parallel subagents execute concurrently:
1. **Worktree Formula Bumping:** Formula bumps are isolated per feature branch to avoid git index lock conflicts on `Formula/*.rb`.
2. **Local Tap Testing:** Local development uses `brew install --build-from-source ./Formula/<tool>.rb` without conflicting with global tap definitions.

---

## 5. Threat Model & Adversarial Attack Vectors (STRIDE)

| Threat Category | Concrete Attack Vector | Packaging Defense & Invariant |
| :--- | :--- | :--- |
| **Spoofing** | Compromised upstream URL pointing to malicious tarball | SHA-256 checksum mismatch aborts installation immediately |
| **Tampering** | Man-in-the-middle tampering during bottle download | GitHub Releases enforced over TLS; SHA-256 verification |
| **Repudiation** | Releasing unvetted formula changes | Cryptographic GPG commit signing (`7BB5B44244E586B0`) required |
| **Information Disclosure** | Exposing private build paths in bottles | Go compiler `-trimpath` enforced in upstream release builds |
| **Denial of Service** | Corrupted formula crashing brew update | `brew audit --strict` runs on every pull request |
| **Elevation of Privilege** | SUID binary or root installation bypass | Formulae strictly install as unprivileged user into Cellar |

---

## 6. Essential Commands & Verification Suite

```bash
# Audit formula syntax and styling
brew audit --strict Formula/fabrial.rb
brew audit --strict Formula/airlock.rb

# Test local formula installation from file
brew install --build-from-source ./Formula/airlock.rb

# Run formula integration test block
brew test airlock

# Lint ruby formula code
brew style Formula/
```

---

## 7. Strict Commit & Signing Invariants

1. **Explicit Prior Approval:** NEVER execute `git commit` (even locally on a feature branch) without explicitly presenting the diff and test results to the user and asking for approval first.
2. **Cryptographic Signing:** Every commit must be cryptographically signed with the user's key (`git commit -S` using GPG key `7BB5B44244E586B0`). Never pass `--no-gpg-sign`.
3. **Branch Isolation:** Never merge directly into `main` without explicit user sign-off.
