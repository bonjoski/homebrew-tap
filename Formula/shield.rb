# typed: false
# frozen_string_literal: true

# Formula for Shield (bonjoski/shield)
# Sovereign Client-Side Secret Shielding & Fail-Closed Wire Guard for AI Agents
class Shield < Formula
  desc "Sovereign client-side secret shielding and fail-closed wire guard for AI agents"
  homepage "https://github.com/bonjoski/shield"
  url "https://github.com/bonjoski/shield/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "12e70757b0bffd1c5e79be3e88252715cffae89880ae60423a4dd7519c8a9121"
  license "MIT"
  head "https://github.com/bonjoski/shield.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/shield"
  end

  def caveats
    <<~EOS
      🛡️ Shield Sovereign Secret Shielding Proxy has been installed!

      To start the loopback proxy daemon for Cursor, Claude Code, and Antigravity:
        shield proxy --port 8080

      To sanitize a string directly via CLI:
        shield redact "<text with secrets>"
    EOS
  end

  test do
    assert_match "shield version", shell_output("#{bin}/shield version 2>&1")
  end
end
