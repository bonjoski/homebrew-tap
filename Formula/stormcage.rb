# typed: false
# frozen_string_literal: true

# Formula for Stormcage (bonjoski/stormcage)
# Zero-Latency MCP Context Firewall, Taint Tracker, and Intent Engine
class Stormcage < Formula
  desc "In-process prompt and context sanitization Go library for multi-agent workflows"
  homepage "https://github.com/bonjoski/stormcage"
  url "https://github.com/bonjoski/stormcage/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "50856587bbcf2ca6a10eaa95b14e92a27ef151d4aaf688f1ed01fbdd062ddc0c"
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
