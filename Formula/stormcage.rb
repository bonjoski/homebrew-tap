# typed: false
# frozen_string_literal: true

# Formula for Stormcage (bonjoski/stormcage)
# Zero-Latency MCP Context Firewall, Taint Tracker, and Intent Engine
class Stormcage < Formula
  desc "Zero-latency MCP context firewall, taint tracker, and intent engine for multi-agent workflows"
  homepage "https://github.com/bonjoski/stormcage"
  url "https://github.com/bonjoski/stormcage/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "7bbb06a81223830a657ab35ed4728b614ef6d410c4f56f041bdd4057e31d9b58"
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
    assert_match "stormcage", shell_output("#{bin}/stormcage version 2>&1")
  end
end
