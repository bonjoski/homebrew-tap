# typed: false
# frozen_string_literal: true

# Formula for Argus (bonjoski/argus)
# Pre-Flight Dependency Provenance & Slopsquatting Interceptor
class Argus < Formula
  desc "Pre-flight dependency provenance and slopsquatting interceptor"
  homepage "https://github.com/bonjoski/argus"
  url "https://github.com/bonjoski/argus/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "14e902fe1c89abc6b9c8f17da1a94a017fdfb0d4bd906d49b671e3c0c4ccc983"
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
