# typed: false
# frozen_string_literal: true

# Formula for Stormcage (bonjoski/stormcage)
# Zero-Latency MCP Context Firewall, Taint Tracker, and Intent Engine
class Stormcage < Formula
  desc "Zero-latency MCP context firewall, taint tracker, and intent engine for multi-agent workflows"
  homepage "https://github.com/bonjoski/stormcage"
  url "https://github.com/bonjoski/stormcage/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "089200f3f4466d3f93e72fb3d2a51b4b688f32c11b88d53ab7e74c18eacb18cf"
  license "MIT"
  head "https://github.com/bonjoski/stormcage.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/stormcage"
  end

  def caveats
    <<~EOS
      ⚡ Stormcage Multi-Agent Context Firewall has been installed!

      To start the MCP context firewall proxy:
        stormcage proxy --upstream-mcp <url> --port 9090

      To inspect context taint tracking:
        stormcage taint status
    EOS
  end

  test do
    assert_match "stormcage version", shell_output("#{bin}/stormcage version 2>&1")
  end
end
