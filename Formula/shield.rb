# typed: false
# frozen_string_literal: true

# Formula for Shield (bonjoski/shield)
# Sovereign Client-Side Secret Shielding & Fail-Closed Wire Guard for AI Agents
class Shield < Formula
  desc "Local client-side secret redactor and loopback wire guard proxy for AI agents"
  homepage "https://github.com/bonjoski/shield"
  url "https://github.com/bonjoski/shield/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "65b91e60413b85e2f716165f7144812b956886ff1344d098fe280b11a6d8d548"
  license "Apache-2.0"
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
