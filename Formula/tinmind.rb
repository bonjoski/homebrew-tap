# typed: false
# frozen_string_literal: true

# Formula for Tinmind (bonjoski/tinmind)
# Sovereign local PTY flight recorder & deterministic Safe-ANSI TTY replay for AI coding agents
class Tinmind < Formula
  desc "Sovereign local PTY flight recorder and deterministic TTY replay for AI agents"
  homepage "https://github.com/bonjoski/tinmind"
  url "https://github.com/bonjoski/tinmind/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4f3dcddfdf7377118f6c5ca864f3222ee4b37c3c7c4c07db4f32b6992b7bdc4b"
  license "Apache-2.0"
  head "https://github.com/bonjoski/tinmind.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/bonjoski/tinmind/pkg/version.Version=#{version}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/tinmind"
  end

  test do
    assert_match "tinmind v#{version}", shell_output("#{bin}/tinmind --version")
  end
end
