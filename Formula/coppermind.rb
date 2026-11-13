# typed: false
# frozen_string_literal: true

# Formula for Coppermind (bonjoski/coppermind)
# Portable Cognitive AI Brain & Sovereign Agent Memory Runtime
class Coppermind < Formula
  desc "Portable cognitive AI brain and sovereign agent memory runtime"
  homepage "https://github.com/bonjoski/coppermind"
  url "https://github.com/bonjoski/coppermind/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b9ccfbc4d8b2b6a3ce5fc702fe233806c804f9003dadcd87b78c82231cddceaa"
  license "Apache-2.0"
  head "https://github.com/bonjoski/coppermind.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/bonjoski/coppermind/pkg/version.Version=#{version} -X github.com/bonjoski/coppermind/pkg/version.Commit=v#{version}"), "./cmd/coppermind"
  end

  def caveats
    <<~EOS
      🧠 Coppermind Cognitive AI Brain & Agent Memory Runtime installed!

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
