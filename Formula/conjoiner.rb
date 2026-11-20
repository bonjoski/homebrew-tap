# typed: false
# frozen_string_literal: true

# Formula for Conjoiner (bonjoski/conjoiner)
# Sovereign Agentic IAM Broker, Token Attenuation, and Policy Gateway
class Conjoiner < Formula
  desc "Deterministic tool gateway and RFC 9449 DPoP token library for AI agents"
  homepage "https://github.com/bonjoski/conjoiner"
  url "https://github.com/bonjoski/conjoiner/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "91ee06114436ada5077f6aba59cd82fbca7c1a3119f9189ad27a41989db34e94"
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
