# bonjoski/homebrew-tap

Official Homebrew tap for the Bonjoski security ecosystem.

This tap provides formulas for:
- **[Fabrial](https://github.com/bonjoski/fabrial)** – Sovereign AI agent security fabric unifying Airlock, Locksmith, Aegisbox, and Argus.
- **[Aegisbox](https://github.com/bonjoski/aegisbox)** – MicroVM confinement hypervisor, desktop cockpit, and adversarial range engine.
- **[Airlock](https://github.com/bonjoski/airlock)** – Zero-trust workstation sandbox for untrusted package installs & agentic AI loops.
- **[Argus](https://github.com/bonjoski/argus)** – Pre-flight dependency provenance and slopsquatting interceptor.
- **[Locksmith](https://github.com/bonjoski/locksmith)** – Hosted in [`bonjoski/homebrew-locksmith`](https://github.com/bonjoski/homebrew-locksmith). Secure macOS keychain-backed secrets manager with Touch ID / Apple Watch biometric authentication and desktop cockpit.

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
brew install bonjoski/locksmith/locksmith
```
