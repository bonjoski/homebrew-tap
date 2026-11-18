# bonjoski/homebrew-tap

Official Homebrew tap for the Bonjoski sovereign AI agent security ecosystem.

> [!NOTE]
> **Developer Tooling & Safe Harbor Scope**: All formulas in this tap distribute personal developer workstation utilities running strictly on localhost with zero multi-tenant cloud control planes or commercial enterprise AI runtime security features.

This tap provides formulas for:
- **[Fabrial](https://github.com/bonjoski/fabrial)** – Sovereign AI agent security fabric unifying Airlock, Locksmith, Aegisbox, and Argus.
- **[Aegisbox](https://github.com/bonjoski/aegisbox)** – MicroVM confinement hypervisor, desktop cockpit, and adversarial range engine.
- **[Airlock](https://github.com/bonjoski/airlock)** – Zero-trust workstation sandbox for untrusted package installs & agentic AI loops.
- **[Argus](https://github.com/bonjoski/argus)** – Pre-flight dependency validator and local typosquatting package scanner.
- **[Bomhound](https://github.com/bonjoski/bomhound)** – High-performance SBOM copyright & legal provenance enrichment engine.
- **[Shield](https://github.com/bonjoski/shield)** – Local client-side secret redactor and loopback wire guard proxy for AI agents.
- **[Conjoiner](https://github.com/bonjoski/conjoiner)** – Deterministic tool gateway and RFC 9449 DPoP reference library for local agent CLI tools.
- **[Stormcage](https://github.com/bonjoski/stormcage)** – In-process prompt and context sanitization Go library for multi-agent test harnesses.
- **[Soulcaster](https://github.com/bonjoski/soulcaster)** – Sovereign compiler wrapper and in-toto provenance attestation engine.
- **[Locksmith](https://github.com/bonjoski/locksmith)** – Secure macOS keychain-backed secrets manager with Touch ID / Apple Watch biometric authentication and desktop cockpit.

---

## 🚀 Installation

Tap the repository:
```bash
brew tap bonjoski/tap
```

Install Fabrial (automatically installs all four pillars: Aegisbox, Airlock, Argus, and Locksmith):
```bash
brew install fabrial
```

Or install individual tools:
```bash
brew install bonjoski/tap/fabrial
brew install bonjoski/tap/aegisbox
brew install bonjoski/tap/airlock
brew install bonjoski/tap/argus
brew install bonjoski/tap/shield
brew install bonjoski/tap/conjoiner
brew install bonjoski/tap/stormcage
brew install bonjoski/tap/soulcaster
brew install bonjoski/tap/bomhound
brew install bonjoski/tap/locksmith
```
