# typed: false
# frozen_string_literal: true

# Formula for Coppermind (bonjoski/coppermind)
# Local-First AI Memory System for Coding Agents
class Coppermind < Formula
  desc "Local-first AI memory system for coding agents"
  homepage "https://github.com/bonjoski/coppermind"
  url "https://github.com/bonjoski/coppermind/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "b91b990779e7ff3ccf9d38889333ba02bba09641a62329473d57f1c84778352f"
  license "Apache-2.0"
  head "https://github.com/bonjoski/coppermind.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/bonjoski/coppermind/pkg/version.Version=#{version} -X github.com/bonjoski/coppermind/pkg/version.Commit=v#{version}"), "./cmd/coppermind"
  end

  def caveats
    <<~EOS
      🧠 Coppermind Local-First AI Memory System installed!

      To start the native Model Context Protocol (MCP) server:
        coppermind mcp

      To run the 10-pillar diagnostic inspection:
        coppermind doctor

      To manage isolated project vaults:
        coppermind project list
        coppermind project use <name>

      To scan and index a codebase repository:
        coppermind index

      To install the automated episodic git commit hook in your current repository:
        coppermind hook install
    EOS
  end

  test do
    assert_match "coppermind version", shell_output("#{bin}/coppermind version 2>&1")
  end
end
