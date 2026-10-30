# typed: false
# frozen_string_literal: true

# Formula for Argus (bonjoski/argus)
# Pre-Flight Dependency Provenance & Slopsquatting Interceptor
class Argus < Formula
  desc "Pre-flight dependency provenance and slopsquatting interceptor"
  homepage "https://github.com/bonjoski/argus"
  url "https://github.com/bonjoski/argus/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "b012891e580c34b585347c338fd49c27bbbd997685d37b4922cf6e3ca11f09e0"
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
