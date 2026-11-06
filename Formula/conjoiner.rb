# typed: false
# frozen_string_literal: true

# Formula for Conjoiner (bonjoski/conjoiner)
# Sovereign Agentic IAM Broker, Token Attenuation, and Policy Gateway
class Conjoiner < Formula
  desc "Sovereign NIST-aligned agentic IAM broker, token attenuation, and policy gateway"
  homepage "https://github.com/bonjoski/conjoiner"
  url "https://github.com/bonjoski/conjoiner/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "3ccf6244da636c5e32ef6cd43a9082fcb476ad78d7070e51070fb9875f92b55f"
  license "MIT"
  head "https://github.com/bonjoski/conjoiner.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/conjoiner"
    bin.install_symlink bin/"conjoiner" => "mcp-conjoiner-proxy"
  end

  def caveats
    <<~EOS
      🔗 Conjoiner Agentic IAM Broker & MCP Transport Shim has been installed!

      To transparently protect an MCP server in Cursor, Claude Code, or Windsurf:
        Set MCP command to "mcp-conjoiner-proxy" followed by "--" and the server command:
          "command": "mcp-conjoiner-proxy",
          "args": ["--", "npx", "-y", "@modelcontextprotocol/server-postgres", "..."]

      To issue task-attenuated tokens:
        conjoiner token issue --scope "fs:read:/workspace,tool:exec:git:status"

      To compile natural language mandates into capability scopes:
        conjoiner mandate compile --ai "<natural language policy>"
    EOS
  end

  test do
    assert_match "conjoiner version", shell_output("#{bin}/conjoiner version 2>&1")
    assert_match "Usage:", shell_output("#{bin}/mcp-conjoiner-proxy 2>&1", 1)
  end
end
