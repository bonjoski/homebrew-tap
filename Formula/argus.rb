# typed: false
# frozen_string_literal: true

# Formula for Argus (bonjoski/argus)
# Pre-Flight Dependency Provenance & Slopsquatting Interceptor
class Argus < Formula
  desc "Pre-flight dependency validator and local typosquatting package scanner"
  homepage "https://github.com/bonjoski/argus"
  url "https://github.com/bonjoski/argus/archive/refs/tags/v0.11.5.tar.gz"
  sha256 "bf95a633c9f789fd0add00dfd780a1689d1ae83920fbd76711d4c43c1d62d0d3"
  license "Apache-2.0"
  head "https://github.com/bonjoski/argus.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X bonjoski/argus/internal/version.Version=v#{version}
      -X bonjoski/argus/internal/version.GitCommit=brew
      -X bonjoski/argus/internal/version.BuildDate=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/argus"
    system "go", "build", *std_go_args(output: bin/"argus-shim", ldflags: ldflags.join(" ")), "./cmd/argus-shim"
  end

  test do
    assert_match "argus version", shell_output("#{bin}/argus version 2>&1")
  end
end
