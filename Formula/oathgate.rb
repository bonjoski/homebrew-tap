# typed: false
# frozen_string_literal: true

# Formula for Oathgate (bonjoski/oathgate)
# Instant Copy-on-Write time-travel workspace checkpoints for coding agents
class Oathgate < Formula
  desc "Instant Copy-on-Write time-travel workspace checkpoints for coding agents"
  homepage "https://github.com/bonjoski/oathgate"
  url "https://github.com/bonjoski/oathgate/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "66623ebc9b25eff3d656e99c73ebf4056e3f6cedf3c726e205b28b995353c8de"
  license "Apache-2.0"
  head "https://github.com/bonjoski/oathgate.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/bonjoski/oathgate/pkg/version.Version=#{version}
    ]

    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/oathgate"
  end

  test do
    assert_match "oathgate v#{version}", shell_output("#{bin}/oathgate --version")
  end
end
