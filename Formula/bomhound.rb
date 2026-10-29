# typed: false
# frozen_string_literal: true

# Formula for Bomhound (bonjoski/bomhound)
# High-performance CLI tool and Go library for enriching Software Bill of Materials (SBOMs)
class Bomhound < Formula
  desc "Enrich SBOMs with copyright, provenance, and legal attribution notices"
  homepage "https://github.com/bonjoski/bomhound"
  url "https://github.com/bonjoski/bomhound/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "7b575403c389d470fca9d12dcd0ee61453af2e041363d3fb464bffd648f4236f"
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
