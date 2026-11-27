# typed: false
# frozen_string_literal: true

# Formula for Tinmind (bonjoski/tinmind)
# Sovereign local PTY flight recorder & deterministic Safe-ANSI TTY replay for AI coding agents
class Tinmind < Formula
  desc "Sovereign local PTY flight recorder and deterministic TTY replay for AI agents"
  homepage "https://github.com/bonjoski/tinmind"
  url "https://github.com/bonjoski/tinmind/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f7cf6cb74c95869ad7ff8583adace62d01daf653864227c498ed37d22e249754"
  license "MIT"
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
