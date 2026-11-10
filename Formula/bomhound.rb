# typed: false
# frozen_string_literal: true

# Formula for Bomhound (bonjoski/bomhound)
# High-performance CLI tool and Go library for enriching Software Bill of Materials (SBOMs)
class Bomhound < Formula
  desc "Enrich SBOMs with copyright, provenance, and legal attribution notices"
  homepage "https://github.com/bonjoski/bomhound"
  url "https://github.com/bonjoski/bomhound/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "4bfd0259597b862178c295938091727e69760e44ac9a13b23ea2d3a72d86a64d"
  license "Apache-2.0"
  head "https://github.com/bonjoski/bomhound.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/bonjoski/bomhound/pkg/bomhound.Version=#{version}
      -X github.com/bonjoski/bomhound/pkg/bomhound.GitCommit=brew
      -X github.com/bonjoski/bomhound/pkg/bomhound.BuildDate=#{time.iso8601}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/bomhound"
  end

  test do
    assert_match "bomhound v#{version}", shell_output("#{bin}/bomhound --version")
  end
end
