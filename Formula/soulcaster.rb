# typed: false
# frozen_string_literal: true

# Formula for Soulcaster (bonjoski/soulcaster)
# Sovereign Compiler Wrapper & In-Toto Provenance Attestation Engine
class Soulcaster < Formula
  desc "Sovereign compiler wrapper and in-toto provenance attestation engine"
  homepage "https://github.com/bonjoski/soulcaster"
  url "https://github.com/bonjoski/soulcaster/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "ab6947f2434597a693edef07462e13af7f4d5443fa5ac0424df8325897733848"
  license "Apache-2.0"
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
