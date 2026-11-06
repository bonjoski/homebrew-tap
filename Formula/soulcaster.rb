# typed: false
# frozen_string_literal: true

# Formula for Soulcaster (bonjoski/soulcaster)
# Sovereign Compiler Wrapper & In-Toto Provenance Attestation Engine
class Soulcaster < Formula
  desc "Sovereign compiler wrapper and in-toto provenance attestation engine"
  homepage "https://github.com/bonjoski/soulcaster"
  url "https://github.com/bonjoski/soulcaster/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "44cb013b1fa6f88a76e8b333d278a7101eaef2c9de21adfe708645c58c24e0ca"
  license "MIT"
  head "https://github.com/bonjoski/soulcaster.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/soulcaster"
  end

  def caveats
    <<~EOS
      ✨ Soulcaster Compiler Wrapper & Provenance Attestation has been installed!

      To wrap compiler execution with in-toto attestation:
        soulcaster wrap -- go build ./...

      To verify compilation provenance:
        soulcaster verify --attestation provenance.intoto.json
    EOS
  end

  test do
    assert_match "soulcaster version", shell_output("#{bin}/soulcaster version 2>&1")
  end
end
