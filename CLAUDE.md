# Claude Code Guidelines for `homebrew-tap`

> **Authoritative Ecosystem Runbook:** [`spanreed/docs/knowledge-base/11-distribution-tap.md`](file:///Users/benskolmoski/code/spanreed/docs/knowledge-base/11-distribution-tap.md)

## Build & Test Commands
- **Audit All Formulas:** `brew audit --strict Formula/*.rb`
- **Lint Style:** `brew style Formula/`
- **Test Formula Install:** `brew install --build-from-source ./Formula/<formula>.rb`
- **Run Formula Test:** `brew test <formula>`

## Packaging & Entitlement Invariants
- Preserve macOS hardware entitlements (`keychain-access-groups`, `com.apple.security.hypervisor`).
- SHA-256 bottle and release tarball pinning matching GitHub Release assets.
- Uninstallation hooks must not leave orphaned sockets in `~/.bonjoski/`.

## Commit Invariants
- Mandatory cryptographic signing with GPG key `7BB5B44244E586B0` (`git commit -S`).
- Present diff and test output for explicit user sign-off before committing.
