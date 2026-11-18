# typed: false
# frozen_string_literal: true

# Formula for Shield (bonjoski/shield)
# Sovereign Client-Side Secret Shielding & Fail-Closed Wire Guard for AI Agents
class Shield < Formula
  desc "Local client-side secret redactor and loopback wire guard proxy for AI agents"
  homepage "https://github.com/bonjoski/shield"
  url "https://github.com/bonjoski/shield/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "613880a03c830bdf4e12be4e8569b3ff2cdb92a301bb5e7c467d679357a197dc"
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
    assert_match "bonjoski sovereign BYO-AI shield", shell_output("#{bin}/shield version 2>&1")
  end
end
